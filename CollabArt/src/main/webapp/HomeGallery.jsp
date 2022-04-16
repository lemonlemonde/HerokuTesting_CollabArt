<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "util.Likes" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://kit.fontawesome.com/1a5a91d3bb.js"
	crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap"
	rel="stylesheet">

<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="css/navbar.css">

<script>
//once we figure out how to initialize each picture in the gallery, update the code here to reflect that
const LIKED = 1;
const DISLIKED = -1;
const UNLIKED = 0;
var likeState = {UNLIKED}; //this is to make it 1-indexed
</script>

<title> Collabart | Home</title>
</head>
<body>
	<script id="replace_with_navbar" src="js/nav.js"></script>

	<!-- Thoughts: doing likes/dislikes will be hard: whenever they click on it, need to send update to database
   In addition, need to keep track of each user's likes, dislikes, to make sure they can't like multiple times? 
   Have to do AJAX to see likes go up/down? increment/display locally then update to true value on reload? Or get update when like?-->
      
      
   <br>
   <h1>Collabart Gallery</h1>




	<br>
	<!-- Text, image, and like count will all be grabbed from database. Can also add unique id to each galart element -->
	<!-- Would we have to store all images? Even if we have local path, how would we store it? -->
	
	<div class="galart" id="galart1">
		<script> //figure out how to intialize this for each image we display
			likeState.add((GetId("galart1")));
			fetch('/CollabArt/LikeDispatcher', method = 'POST')
		</script>
		<div class="galart-top blue top-rounded">
			<p>Draw... <span>a cat playing basketball</span></p>
		</div>
		<!-- Images should be a bit wider, maybe something like 3:2? -->
		<div class="galart-mid">
			<img class=galart-img src="images/cat_basketball.png">
		</div>
		<div class="galart-bottom pink bottom-rounded">
			<!-- Also put id on each art's thumbs up and thumbs down? -->
			<i class="fa-solid fa-thumbs-up"></i> <span>&emsp;<%= Likes.GetLike(GetId("galart1"))%> Likes&emsp;</span> <i class="fa-solid fa-thumbs-down"></i>
		</div>
	</div>
	<%System.out.println("true"); %>
	<!-- Script to read thumbs up and thumbs down: -->
	<script>
   let thumbsup = Array.from(document.getElementsByClassName("fa-thumbs-up"));
   let thumbsdown = Array.from(document.getElementsByClassName("fa-thumbs-down"));
   
   console.log(thumbsup);
   console.log(thumbsdown);
   
   function handletup(event) {
       console.log(event.target.parentElement.parentElement.id);
       liketext=event.target.nextElementSibling.innerHTML;
       console.log(liketext);
       document.body.setAttribute('currPic', event.target.parentElement.parentElement.id);
       //likes=parseInt(liketext);
       //likes++;
       <%System.out.println("We run this for some reason");
       int picId = 1;
       Likes.Like(picId, "user");%>
       likes = <%= Likes.GetLike(picId)%>;
       event.target.nextElementSibling.innerHTML="\&emsp;"+likes+" Likes\&emsp;";
       //Update database based on parent div id.
     
       //Update 
       event.target.style.color = "blue";
       event.target.nextElementSibling.nextElementSibling.style.opacity = 0.5;
       event.target.removeEventListener('click', handletup);
       event.target.nextElementSibling.nextElementSibling.removeEventListener('click', handletdown);
    };
   
   function handletdown(event) {
       console.log(event.target.parentElement.parentElement.id);
       liketext=event.target.previousElementSibling.innerHTML;
       console.log(liketext);
       likes=parseInt(liketext);
       likes--;
       event.target.previousElementSibling.innerHTML="\&emsp;"+likes+" Likes\&emsp;";
       //Update database based on parent div id.
       
       event.target.style.color = "blue";
       event.target.previousElementSibling.previousElementSibling.style.opacity = 0.5;
       event.target.removeEventListener('click', handletdown);
       event.target.previousElementSibling.previousElementSibling.removeEventListener();
    };
    
   thumbsup.map( tup => {
	   tup.addEventListener('click', handletup);
   });
   
   thumbsdown.map( tdown => {
	   tdown.addEventListener('click', handletdown);
	});
      
   </script>
   
   <%!
   //Get pic id from galart1
   public int GetId(String text) {
	   if (text == null) {
		   System.out.println("Null String");
		   return 0;
	   }
	   if (text.length() > 6) {
		   String t = text.substring(6);
		   System.out.println("Proper String");
		   try {
			   return Integer.parseInt(t);
		   } catch (NumberFormatException e) {
			   System.out.println ("ParseIntException: " + e.getMessage());
			   return 0;
		   }
	   } else {
		   return 0;
	   }
   }
   %>
</body>
</html>