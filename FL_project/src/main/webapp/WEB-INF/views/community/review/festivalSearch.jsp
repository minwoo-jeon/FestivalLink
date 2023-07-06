<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
	header.header-section, div.container-fluid{
		display:none;
	}

	ul.festnames{
		list-style:none;
	}
	
	a.festname{
		cursor:pointer;
	}
</style>

<script>
	const autoComp = function(val){
		$.ajax({
			type:"post",
			url:"autoComp",
			data:"keyword="+val,
			dataType:"json",
			cache:false
		}).done((res)=>{
			let str = "<ul class='festnames'>";
			$.each(res, function(i, title){
				str += "<li><a class='festname' onclick='setting(\""+title+"\")'>";
				str += title;
				str += "</li>"
			});
			str += "</ul>";
			$("#lst2").html(str).show("slow");
			$("#lst1").show("slow")
		}).fail((err)=>{
			alert(err.status);
		});
	}
	
	const setting = function(val){
		$("#festname").val(val);
		$("#lst2").hide();
		$("#lst1").hide();
		$("#confirm").show();
	};
	
	const setName = function(){
		opener.document.rf.festName.value = $("#festname").val();
		self.close();
	};
</script>

<div class="container m2" style="margin-top: 2em">
	<div>
		<label for="festname" class="control-label col-sm-6">축제 이름</label>
		<div class="col-sm-6">
			<input type="text" name="festname" id="festname"
				onkeyup="autoComp(this.value)" placeholder="축제 검색" class="form-control">
			<div id="lst1" class="listbox bg-light mt-3" style="display: none">
				<div id="lst2" class="flist" style="display: none"></div>
			</div>
			<button id="confirm" class="btn btn-secondary mt-3" onclick="setName()" style="display: none">확인</button>
		</div>
	</div>
</div>