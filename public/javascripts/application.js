// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function deselect_checkboxes(){
	jQuery.each(deselect_checkboxes.arguments, function(index, value){
		$(value).attr("checked", false);
	});
}

function select_checkboxes(){
	jQuery.each(select_checkboxes.arguments, function(index, value){
		$(value).attr("checked", true);
	});
}

var paginate_jump_field = -1;
$(document).ready(function(){
	$("#paginate_jump_field").click(function(){
		this.select();
	});
});

function open_close_popup(link, box){
	var popup = $(box)
	
	if(popup.css("display") == "none"){
		popup.position({
			my: "left top",
			at: "left bottom",
			of: link,
			collision: "flip none"
		});
		popup.css("display", "block")
	}else{
		popup.css("display", "none")
	}
}

function random_quote(){
	quotes = Array(
		"As seen on online.",  //futurma
		"It's a long story although it's kind of a short one.",
		"It's like a tree with forests!",
		"It's only a model.", //monty python: search for the holy grail
		"I despise guessing games.", //lion king
		"A literature community for fiction.", 
		"Scientific classification: awesome.",
		"A byproduct of \"art\" websites hosting \"literature\" badly.",
		"Now with 4% less fail.",
		"Give me a carafe of your finest whiskey", //Cheers
		"If you find a feature, please report it. It shouldn't be there.",
		"The Spectral Wolf fears only Fire.", //xkcd 461
		"There, wolf. There, castle.", //Young Frankstein
		"Yeah. After all, tonight is a full moon.", //Wolf's Rain
		"Is it time to kill another character?", 
		"My Lord, Is that legal?",	//Star Wars: Episode 1
		"I will make it legal!", //Star Wars: Episode 1
		"Now will you please put some clothes on.", //Avatar: The Last Air Bender
		"It's not gravel, it's grovel.", //Lion King
		"It doesn't matter. It's in the past!", //Lion King
		"All hail the almighty dom0!", //Reference to server virtualization. 
		"I will preform the opening prayer in the New Latin.", //monty python: search for the holy grail
		"Lorem ipsum dolor sit amet, consectetur.", // lorem ipsum
		"Lorem ipsum dolor sign, amen.", // lorem ipsum
		"Support your local coffeeshop.",
		"Coffee is my shepherd, I shall not doze.", //unknown
		"Not a Substitute for Human Interaction", //futurma
		"I'm just a guy... with a boomerang",	//Avatar: The Last Air Bender
		"This is gonna ruin my whole day!", //Avatar (2009)
		"Come back when it's a catastrophe.", //Futurma
		"That was food? I used it to start the campfire last night.", //Avatar: The Last Air Bender
		"Take that you rock!", //Avatar: The Last Air Bender
		"Hey you kids! Get off my lawn!",
		"And there was much rejoicing.", //monty python: search for the holy grail
		"I'll get the powder, sir" //futurma
	);
	return quotes[Math.floor(Math.random() * quotes.length)];
}

$(function(){ $("#tag-line").html(random_quote()) });