/*
This is empty on purpose! Your code to build the resume will go here.
 */





//  function inName(name) {

// 	name = name.trim().split(" ");
// 	console.log(name);
// 	name[1] = name[1].toUpperCase();
// 	name[0] = name[0].slice(0,1).toUpperCase()+name[0].slice(1).toLowerCase();
	
// 	return name[0]+" "+name[1];

// }

// inName(name);

// $("#header").append(internationalizeButton);



$("#header").append(formattedName);
$("#header").append(formattedRole);



var bio = {
	"name" : "Caroline",
	"role" : "Web Developer",
	"contacts":{
		"mobile":"0909099967",
		"email":"kyujyokei@gmail.com",
		"github":"kyujyokei",
		"twitter" :"you wont want to know",
		"location" :"Chiayi",
		"blog" : "Dont have one"
	},
	"skills" : ["Sleep all day","Frontend development","Eat lots of stuff"],
	"biopic" : "images/MrSaturn.png"
};

var formattedPic = HTMLbioPic.replace("%data%",bio.biopic);
$("#header").append(formattedPic);

var formattedName = HTMLheaderName.replace("%data%", bio.name);
$("#header").append(formattedName);
var formattedRole = HTMLheaderRole.replace("%data%", bio.role);
$("#header").append(formattedRole);
var formattedMobile = HTMLmobile.replace("%data%", bio.contacts.mobile);
$("#header").append(formattedMobile);
var formattedEmail = HTMLemail.replace("%data%", bio.contacts.email);
$("#header").append(formattedEmail);
var formattedGithub = HTMLgithub.replace("%data%",bio.contacts.github);
$("#header").append(formattedGithub);
var formattedTwitter = HTMLtwitter.replace("%data%",bio.contacts.twitter);
$("#header").append(formattedTwitter);
var formattedBlog = HTMLblog.replace("%data%",bio.blog);
$("#header").append(formattedBlog);
var formattedLocation = HTMLlocation.replace("%data%",bio.contacts.location);
$("#header").append(formattedLocation);


 if (bio.skills != 0){
 	 $("#header").append(HTMLskillsStart);
 }

 var formattedSkill = HTMLskills.replace("%data%", bio.skills[0]);
 $("#skills").append(formattedSkill);
	 formattedSkill = HTMLskills.replace("%data%", bio.skills[1]);
$("#skills").append(formattedSkill);
	 formattedSkill = HTMLskills.replace("%data%", bio.skills[2]);
$("#skills").append(formattedSkill);




//var project = {};

var work = {
	"jobs":[
		{
	"job" : "eat food",
	"title" : "bubui who eats rice",
	"position" : "bubui",
	"location" : "Las Vegas",
	"employer" : "Company A",
	"years" : 2,
	"dates" : "2013-2015",
	"description" : "There are many varieties of dishes called curries. For example, in original traditional cuisines,Traditionally, spices are used both whole and ground; cooked or raw; and they may be added at different times during the cooking process to produce different results. The main spices found in most curry powders of the Indian subcontinent are coriander, cumin, and turmeric. "
		}
		,
		{
	"job" : "eat food",
	"title" : "bubui who eats meat",
	"position" : "bubui",
	"location" : "Shanghai",
	"employer" : "Company B",
	"years" : 2,
	"dates" : "2013-2015",
	"description" : "The Mr. Saturn (どせいさん Dosei-san) are a species in EarthBound and Mother 3 and serve as the unofficial mascot for the trilogy. They are strange, possibly extra-terrestrial life forms who reside in both Eagleland's Saturn Valley and the Nowhere Islands's Saturn Valley in EarthBound and Mother 3, respectively. They are characterized by huge noses, four whiskers, and a single hair with a small red bow. They are generally very peaceful and generous, offering free coffee and stays at the hotel. They speak Saturnian (composed of odd looking English letters), and in the English translation erratically use the words at the ends of their sentences. The Japanese font is said to be inspired by the handwriting of the young daughter of EarthBound's designer, Shigesato Itoi."
		}

	]

};
	






function displayWork(){
	for (job in work.jobs){
		$("#workExperience").append(HTMLworkStart);
		var formattedEmployer = HTMLworkEmployer.replace("%data%",work.jobs[job].employer);
		var formattedTitle = HTMLworkTitle.replace("%data%",work.jobs[job].title);
		var formattedEmployerTitle = formattedEmployer + formattedTitle;
		var formattedLocation = HTMLworkLocation.replace("%data%",work.jobs[job].location);
		var formattedDates = HTMLworkDates.replace("%data%",work.jobs[job].dates);
		var formattedDescription = HTMLworkDescription.replace("%data%",work.jobs[job].description);

		$(".work-entry:last").append(formattedEmployerTitle);
		$(".work-entry:last").append(formattedDates);
		$(".work-entry:last").append(formattedDescription);
		$(".work-entry:last").append(formattedLocation);
	}
}

displayWork();

// $(document).click(function(loc){
// 	var x = loc.pageX;
// 	var y = loc.pageY;
// 	logClicks(x,y);

// });
var projects = {
	"projects":[
		{
			"title" : "Bubui go to Mars!!!",
			"dates" : "2013",
			"description" : "Bubui officially goes and land on MARS!!! WOW!!!",
			"images" : "images/fry.jpg"
		},
		{
			"title" : "Bubui go to Mars!!!!!!!!!!!",
			"dates" : "2013",
			"description" : "Bubui officially goes and land on MARS!!! WOW!!!",
			"images" : "images/fry.jpg"
		}
	]
};

projects.display = function(){
	for(project in projects.projects){
		$("#projects").append(HTMLprojectStart);

		var formattedTitle = HTMLprojectTitle.replace("%data%",projects.projects[project].title);
		$(".project-entry:last").append(formattedTitle);

		var formattedDates = HTMLprojectDates.replace("%data%",projects.projects[project].dates);
		$(".project-entry:last").append(formattedDates);

		var formattedDescription = HTMLprojectDescription.replace("%data%",projects.projects[project].description);
		$(".project-entry:last").append(formattedDescription);

		//if(projects.projects[project].images.length > 0){
			//for (image in projects.projects[project].images){
				var formattedImage = HTMLprojectImage.replace("%data%",projects.projects[project].images);
				$(".project-entry:last").append(formattedImage);
			//}

		//}
	}

}

projects.display();

var education = {
	"schools":[
		{
			"name" : "NTUST",
			"degree" : "Bachelor of Industrial & Commerial Design",
			"majors" : ["Design"],
			"dates" : 2013,
			"location": "Taipei",
			"url" : "examples.com"
		},
		{
			"name" : "NYUST",
			"degree" : "Bachelor of Eating Costco Food Allday",
			"majors" : ["Design"],
			"location" : "Yunlin",
			"dates" : 2010,
			"url" : "examples.com"
		}
	],
	"onlineCourses":[
		{
			"title" : "Javascript Syntax",
			"school" : "Udacity",
			"dates" : 2016,
			"url" : "http://www.udacity.com"
		}
	]
};

education.display = function(){
	for(i in education.schools){
		$("#education").append(HTMLschoolStart);

		var formattedName = HTMLschoolName.replace("%data%",education.schools[i].name);
		$(".education-entry:last").append(formattedName);
		var formattedDegree = HTMLschoolDegree.replace("%data%",education.schools[i].degree);
		$(".education-entry:last").append(formattedDegree);
		var formattedDates = HTMLschoolDates.replace("%data%",education.schools[i].dates);
		$(".education-entry:last").append(formattedDates);
		var formattedMajor = HTMLschoolMajor.replace("%data%",education.schools[i].majors);
		$(".education-entry:last").append(formattedMajor);
		var formattedLocation = HTMLschoolLocation.replace("%data%",education.schools[i].location);
		$(".education-entry:last").append(formattedLocation);

	};
};

education.display();

$("#mapDiv").append(googleMap);
initializeMap();

