#!/usr/bin/perl
#Author: Nicholas Janich
#Desc: Script to check for shows currently streaming on NetFLix and Hulu-Plus
#todo: add movies, HBOGO, Amazon

print "Enter the full name of a show to search: "; 
chomp($search = <STDIN>); #prompts user to enter which show they are looking for
exit 0 if ($search eq ""); #exits if nothing is entered from user
$count = 0; 	#int to used to check if show is found
my $netflix = "netflix-shows.txt";	#netflix show txt list to read from
my $hulu = "hulu-shows.txt";		#hulu show txt list to read from

open(NFILEREAD, "< $netflix") || die "$netflix can't be opened $! "; #open netflix show list or close if unable to open file
while(<NFILEREAD> ){	#while reading thro file
	chomp($_);	#remove newline characters
	@ndata = split(); #adds split txt file data read into an array
	foreach $word(@ndata){	#searches thro each word put into ndata array
	if ($_ =~ /$search/i){		#searchs for the show the user entered, not case sensitive
		$netflixavail = 1;	#gives value 1 to signify the show was found in netflix shows
	}
	}
}
close NFILEREAD;

open(HFILEREAD, "< $hulu") || die "$hulu can't be opened $! "; #open hulu show list or close if unable to open file
while(<HFILEREAD> ){
        chomp($_);
        @hdata = split();
        foreach $word(@hdata){
        if ($_ =~/$search/i){		
                $huluavail = 1;		#gives value 1 to signify the show was found in netflix shows
        }
        }
}
close HFILEREAD;

if($netflixavail == 1){ 	#checks if netflix value has a 1
	print "The show $search is currently availible on Netflix! \n";	#if 1 the show was found
	}	
else{
	print "The show $search is currently not streaming on Netflix. \n"; #if not 1 the show was not found
	}

if($huluavail == 1){
        print "The show $search is currently availible on Hulu! \n";
        }
else{
        print "The show $search is currently not streaming on Hulu. \n";
        }



