package com.project.service;

import java.io.IOException;
import java.util.UUID;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.introspect.TypeResolutionContext.Empty;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project.domain.YFestivalVO;
import com.project.mapper.YFestivalMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@RequiredArgsConstructor
@Component
public class YFestivalService {

    @Autowired
    YFestivalMapper yFestivalMapper;

    public void festivalDataParse(StringBuilder sb) throws IOException{
        JsonObject obj = (JsonObject) JsonParser.parseString(sb.toString()).getAsJsonObject();
        JsonArray arr = obj.get("response").getAsJsonObject()
                    .get("body").getAsJsonObject()
                    .get("items").getAsJsonArray();
        Connection con;
        for (JsonElement jsonElement : arr) {
            JsonObject temp = jsonElement.getAsJsonObject();
            // 이미지 네이버에서 검색해서 가져오기
            String searchUrl = "https://search.naver.com/search.naver?query="+temp.get("fstvlNm").getAsString();
            
            con=Jsoup.connect(searchUrl);
            Document doc = con.get();
			Elements divElem = doc.select("div.detail_info");
			Elements imgElem = divElem.select("a.thumb > img");
            String imgUrl="";
            for(int j=0; j<imgElem.size(); j++) {
				Element img = imgElem.get(j);
				if(img != null) {
					imgUrl = img.attr("src");
						
				}
			}
                // 이미지 없으면 저장 안하고 넘어가기
            if(imgUrl==""||imgUrl.contains("data:image")){
                continue;
            }
            // System.out.println(temp.get("fstvlNm").getAsString());
            // System.out.println("img: "+imgUrl);


            YFestivalVO fest = new YFestivalVO();
            fest.setFestival_image(imgUrl);
            fest.setFestival_id(UUID.randomUUID().toString());
            fest.setFestival_name(temp.get("fstvlNm").getAsString());
            if(temp.get("rdnmadr").getAsString()==""||temp.get("rdnmadr").getAsString().isEmpty()){
                if(temp.get("lnmadr").getAsString()!=""&&!temp.get("lnmadr").getAsString().isEmpty()){
                    fest.setFestival_addr(temp.get("lnmadr").getAsString());
                }
                else{
                    fest.setFestival_addr("주소 미정");
                }
            }else{
                fest.setFestival_addr(temp.get("rdnmadr").getAsString());
            }
            
            fest.setFestival_contents(temp.get("fstvlCo").getAsString());
            if(temp.get("homepageUrl").getAsString()!=""&&!temp.get("homepageUrl").getAsString().isEmpty()){
                fest.setFestival_homepage(temp.get("homepageUrl").getAsString());
            }
            fest.setFestival_host(temp.get("mnnst").getAsString());
            fest.setFestival_start(temp.get("fstvlStartDate").getAsString());
            fest.setFestival_end(temp.get("fstvlEndDate").getAsString());
            fest.setFestival_place(temp.get("opar").getAsString());
            if(!temp.get("latitude").getAsString().equals("")&&!temp.get("latitude").getAsString().isEmpty()){
                fest.setFestival_latitude(temp.get("latitude").getAsDouble());
            }else{

            }
            if(!temp.get("longitude").getAsString().equals("")&&!temp.get("longitude").getAsString().isEmpty()){
                fest.setFestival_longitude(temp.get("longitude").getAsDouble());
            }
            
            // fest.setFestival_latitude(temp.get("latitude").getAsDouble());
            // fest.setFestival_longitude(temp.get("longitude").getAsDouble());
            yFestivalMapper.insertFestival(fest);
            System.out.println("service end");
        }
       
    }

    


}
