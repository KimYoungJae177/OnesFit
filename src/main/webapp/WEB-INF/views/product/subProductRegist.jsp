<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Product Add</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
       <script src="https://code.jquery.com/jquery-3.5.1.js"></script>

        <style>
            @import url('https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css');
            *{box-sizing: border-box;}
    
            .side-nav {
                position: fixed;
                top: 64px;
                left: 225px;
                width: 225px;
                margin-left: -225px;
                border: none;
                border-radius: 0;
                overflow-y: auto;
                background-color: black;
                bottom: 0;

            }

            .side-nav>li>a {
                width: 225px;
                border-bottom: 1px rgba(0,0,0,.3) solid;
            }

            .side-nav li a:hover,
            .side-nav li a:focus {
                outline: none;
                background-color: dimgrey;
            }
            
            .side-nav li a {
                color: white;
            }
            
            #product_contents{
               position: relative; top: 120px; left: 350px; width: 1500px
            }
            
            #radio{position: relative; top: 3px;}
            
             .container {
                width: 1200px;
                height: 900px;
                margin-left: 307px;
                padding: 20px;
                font-size: 12px;
                    
            }
            
            #product_box {
                background-color: #f6f6f6;
                border: 1px solid #eeeeee;
            }

            .img_notice {
                color: forestgreen;
            }

            #img_title {
                background-color: #f6f6f6;
            }

            .xbox {
                border: 1px dashed black;
                width: 200px;
                height: 200%;
                
            }

            #submit {
                width: 100px;
                height: 30px;
                border: 1px solid #c4c4c4; background-color: rgba(266,266,266,0); color: #c4c4c4; 
            }
            

            
            #xbox2 img{width:200px;height:200px;}
            #xbox2 img:hover{cursor:pointer;}

            #img_box a:hover{cursor: pointer;}
            #prev_View_area:hover{cursor: pointer;}
         #View_area a:hover{cursor:pointer;}
         #xbox2 a:hover{cursor:pointer;}
         
            #shipping_info{border: 1px solid #dfdfdf; width: 800px; font-size: 11px;}
            #shipping_info td{padding: 10px}
            #shipping_info th{text-align: center; height: 50px;}
        </style>
        
         <script>
            function previewImage(targetObj, View_area) {
                var preview = document.getElementById(View_area); //div id
                var ua = window.navigator.userAgent;

                //ie일때(IE8 이하에서만 작동)
                if (ua.indexOf("MSIE") > -1) {
                    targetObj.select();
                    try {
                        var src = document.selection.createRange().text; // get file full path(IE9, IE10에서 사용 불가)
                        var ie_preview_error = document.getElementById("ie_preview_error_" + View_area);


                        if (ie_preview_error) {
                            preview.removeChild(ie_preview_error); //error가 있으면 delete
                        }

                        var img = document.getElementById(View_area); //이미지가 뿌려질 곳

                        //이미지 로딩, sizingMethod는 div에 맞춰서 사이즈를 자동조절 하는 역할
                        img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+src+"', sizingMethod='scale')";
                    } catch (e) {
                        if (!document.getElementById("ie_preview_error_" + View_area)) {
                            var info = document.createElement("<p>");
                            info.id = "ie_preview_error_" + View_area;
                            info.innerHTML = e.name;
                            preview.insertBefore(info, null);
                        }
                    }
                    //ie가 아닐때(크롬, 사파리, FF)
                } else {
                    var files = targetObj.files;
                    for ( var i = 0; i < files.length; i++) {
                        var file = files[i];
                        var imageType = /image.*/; //이미지 파일일경우만.. 뿌려준다.
                        if (!file.type.match(imageType))
                            continue;
                        var prevImg = document.getElementById("prev_" + View_area); //이전에 미리보기가 있다면 삭제
                        if (prevImg) {
                            preview.removeChild(prevImg);
                        }
                        var img = document.createElement("img"); 
                        img.id = "prev_" + View_area;
                        img.classList.add("obj");
                        img.file = file;
                        img.style.width = '200px';
                        img.style.height = '200px';
                        $("#View_area").html("");
                        img.setAttribute('onclick','document.all.file.click();');
                        preview.prepend(img);
                        $("#View_area").css("border","none");
                        if (window.FileReader) { // FireFox, Chrome, Opera 확인.
                            var reader = new FileReader();
                            reader.onloadend = (function(aImg) {
                                return function(e) {
                                    aImg.src = e.target.result;
                                };
                            })(img);
                            reader.readAsDataURL(file);
                        } else { // safari is not supported FileReader
                            //alert('not supported FileReader');
                            if (!document.getElementById("sfr_preview_error_"
                                                         + View_area)) {
                                var info = document.createElement("p");
                                info.id = "sfr_preview_error_" + View_area;
                                info.innerHTML = "not supported FileReader";
                                preview.insertBefore(info, null);
                            }
                        }
                    }
                }
            }
            


            $(function(){
                $('#files').change(function(){
                    const target = document.getElementsByName('files');

                    var html = '';
                    $.each(target[0].files, function(index, file){
                        const fileName = file.name;
                        html += '<img src="'+URL.createObjectURL(file)+'" onclick="document.all.files.click();">'
                        const fileEx = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
                        if(fileEx != "jpg" && fileEx != "png" &&  fileEx != "gif" &&  fileEx != "bmp" && fileEx != "wmv" && fileEx != "mp4" && fileEx != "avi"){
                            alert("파일은 (jpg, png, gif, bmp, wmv, mp4, avi) 형식만 등록 가능합니다.");
                            resetFile();
                            return false;
                        }
                        $("#xbox2").css("border","none");
                        $('#xbox2').html(html);
                    });

                })
                
                $("input:checkbox").on("change",function() {
                   var check = new Array();
                    $('input:checkbox[name=psize]').each(function() {
                         if($(this).is(':checked')){
                            check.push($(this).val());
                         }
                      });
                    $("#subSize").html("");
                    $(".extraOption").html("");
                    for(var i in check){
                       $("#subSize").append("<input type=checkbox class='size' name='size' value="+check[i]+">"+check[i]+"");
                       $(".extraOption").append("<input type=checkbox class='size' name='size' value="+check[i]+">"+check[i]+"");
                    }
                })
                
                $("input[type=number]").on("input",function(){
                   var regex = /^\d{1,1000}$/g;
                   var count = $("input[type=number]").val();
                   if(!regex.test(count)){$("input[type=number]").val("");
                   alert("재고는 숫자만 입력 가능합니다.");
                   $("input[type=number]").focus();}
                })
                
                $("input[name=color]").on("propertychange change keyup paste input",function(){
                   if($("input[name=psize]").is(":checked") == false){$("input[name=color]").val("");
                   alert("사이즈를 선택해주세요.");
                   $("input[name=psize]").focus();}
                })
                
                $(document).on('click', '.minus', function() {
                 $(this).parent().parent().remove();
            });

            $("#optionAdd").on("click",function(){
               if($("input[name=color]").last().parent("div").next().children().is(":checked") == false){alert("옵션 사이즈를 선택해주세요."); return false;}
               $("#colorBox").append("<div style='width:100%;'><div class='subOption' style='width:30%;'><input type='text' name='color'><button type='button' class='minus' style='margin-left: 10px; margin-top:5px'>-</button></div><div class='extraOption opsize'>"+$('#subSize').html()+"</div></div>");
            
            })
                

                $("#input").focusout(function(){
                    if($("#input").val() != ""){
                        var price=$("#input").val();
                        var ctx = /^\d{1,100}$/g;
                        if(!ctx.test(price)){
                            $("#input").val("");
                            alert("숫자만 입력해주세요.");
                            $("#input").focus();}
                    }
                })
// 여기 유찬이형 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                $("#submit").on("click",function(){
                   var check = false;
                   var checkEmpty = false;
                   $("input[name=category]").each(function(){if($(this).is(":checked")){check = true;}});
                        if($("input[name=pname]").val() != ""){
                           if($("input[type=number]").val() > 0){
                    if(check){
                       $("input[name=color]").each(function(){if($(this).val() == ""){checkEmpty=true;}});
                       if(!checkEmpty){
                            if($("input[name=price]").val() != ""){
                               
                                if($("#textArea").val() != ""){
                                    if(document.getElementById("profile_pt").value != "" && $("#files").val() != ""){
                                       

                                       $("input[name=color]").each(function(index1,item1){

                                       var item = $(item1).parent("div");
                                       
                                          $(item1).parent("div").next().children().each(function(index2,item2){
                                             if($(item2).is(":checked")){$(item2).attr("name",$(item1).val());}
                                             
                                          });
                                          
                                       })
                                       
                                       /* var input = $("<input>");
                                       input.attr("type", "hidden");
                                       input.attr("name", "arr");
                                       input.val(arr); 
                                       $('form').append(input); */

                                        alert("상품 등록에 성공하였습니다.");
                                       return true;
                                      
                                    }else{alert("사진을 등록해주세요.");return false;}
                                }else{alert("상품 설명을 입력해주세요");return false;}
                            }else{alert("상품 가격을 입력해주세요.");return false;}
                       }else{alert("색상을 모두 채워주세요"); return false;}
                        }else{alert("상품 분류를 선택해주세요.");
                              return false;}                                                                 
                    }else{
                       alert("재고는 최소 1개이상 가능합니다.");
                       return false;
                    }
                   }else{
                        alert("상품명을 입력해주세요.");
                        return false;}
                })
        // 여기까지~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
            })

        </script>
        
    </head>
    <body>
            <nav class="navbar navbar-inverse navbar-fixed-top">
                <div style="color: white; margin-left: 18px;"><h2>ADMIN</h2></div>
                <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
                <div>
                    <ul class="nav side-nav">
                        <li><a href="#"><i class="fa fa-fw fa-star"></i> DASH BOARD</a></li>  
                        <li> <a href="#"> 상품 관리 </a></li>
                        <li> <a href="#"> 주문 관리 </a></li>
                        <li><a href="">회원 관리</a></li>
                        <li><a href="">Q&A 관리</a></li>
                        <li><a href="">DAILY 게시판</a></li>
                        <li><a href="">공지사항 </a></li>    
                        <li><a href="">팝업 관리</a></li>  
                        <li><a href=""><i class="fa fa-fw fa fa-question-circle"></i> 판매자 정보</a></li>
                    </ul>
                </div>
            </nav>
            <div id="product_contents">
                    <form action="/admin/productAddProc" method="post" enctype="multipart/form-data" accept-charset="utf8">
               
                <b style="font-size: 15px">상품정보</b>
                <br>
                <br>
                <table id="shipping_info" border="1">
                    <tbody>
                     <tr><th>상품명</th><td><input type="text" name="pname"></tr>
                     <tr><th>재고</th><td><input type="number" name="item_count"></tr>
                        <tr>
                            <th style="width: 150px">PRODUCT</th>
                            <td>
                                <div class="address">
                                    <input type="radio" value="outer" id="radio" name="category"> OUTER
                                    <input type="radio" value="top" id="radio" name="category"> TOP
                                    <input type="radio" value="bottom" id="radio" name="category"> BOTTOM
                                    <input type="radio" value="acc" id="radio" name="category"> ACC

                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">PRICE</th>
                            <td><input id="input" style="border: 1px solid #dfdfdf;" name="price"></td>
                        </tr>
                  <tr><th>Size</th><td>
                    <input type=checkbox class="size" name="psize" value="Free">Free
                    <input type=checkbox class="size" name="psize" value="S">S
                    <input type=checkbox class="size" name="psize" value="M">M
                    <input type=checkbox class="size" name="psize" value="L">L
                    <input type=checkbox class="size" name="psize" value="XL">XL
                  </tr>
                    <tr><th>Color</th><td id="colorBox">
                    <div style="width:100%"><div style="width:30%;float:left" class=subOption><input type="text" name="color"><button type="button" class="plus" id="optionAdd" style="margin-left:10px">+</button></div><div id=subSize class="opsize" style="width:70%;"></div></div>
                    </td>
                    </tr>
                        <tr>
                            <th scope="row">
                                Explanation</th>
                            <td>
                                <textarea id="textArea" style="width: 100%; height: 100px; border: 1px solid #dedede" name="content"></textarea> 
                            </td>
                        </tr>
                    </tbody>
                    <tbody>
                        <tr>
                            <th>IMAGE</th>
                                <td>
                                <br> 대표 이미지
                                <div class="xbox" id='View_area' align=center>
                                    <a onclick=document.all.profile_pt.click(); id=atag
                                       style="width: 200px; height: 200px; display: block; line-height: 200px; text-decoration: none; color: gray; font-size: 70px; opacity: 30%">+</a>
                                </div>
                                <input type="file" name="file" id="profile_pt" onchange="previewImage(this,'View_area')" style="display: none;"/>
                                <div class="img_notice">1000 x 1000 권장</div>
                                <br> <br> 이미지
                                <div class="xbox" id=xbox2 align=center>
                                    <a onclick=document.all.files.click();
                                       style="width: 200px; height: 200px; display: block; line-height: 200px; text-decoration: none; color: gray; font-size: 70px; opacity: 30%">+</a>
                                </div>
                                <input multiple="multiple" name="files" id="files" type="file" style="display:none;"/>
                                <div class="img_notice">1000 x 1000 권장</div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br>
                <input type=submit value="등록하기" id=submit
                            style="margin-left: 350px">
            </form>
                </div>    
    </body>
</html>