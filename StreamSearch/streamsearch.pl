#!/usr/bin/perl
#Need to update netlix shows
#Note: case insensitive search

print "Enter the full name of a show to search: ";
chomp($search = <STDIN>);
exit 0 if ($search eq "");

#my $url = ' https://www.finder.com/netflix-tv-shows';
#system("curl $url -o output.txt");
#$see = "output.txt";


$count = 0;
my $netflix = "netflix-shows.txt";
my $hulu = "hulu-shows.txt";

open(NFILEREAD, "< $netflix") || die "$netflix can't be opened $! ";
while(<NFILEREAD> ){
	chomp($_);
	@ndata = split();
	foreach $word(@ndata){
	if ($_ =~ /$search/i){		
		$netflixavail = 1;
	}
	}
}
close NFILEREAD;

open(HFILEREAD, "< $hulu") || die "$hulu can't be opened $! ";
while(<HFILEREAD> ){
        chomp($_);
        @hdata = split();
        foreach $word(@hdata){
        if ($_ =~/$search/i){
                $huluavail = 1;
        }
        }
}
close HFILEREAD;

if($netflixavail == 1){
	print "The show $search is currently availible on Netflix! \n";
	}	
else{
	print "The show $search is currently not streaming on Netflix. \n";
	}

if($huluavail == 1){
        print "The show $search is currently availible on Hulu! \n";
        }
else{
        print "The show $search is currently not streaming on Hulu. \n";
        }



