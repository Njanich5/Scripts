#!/usr/bin/perl
#base script
#add cgi scripts for removal and adding later

#Notes
#InvFile will not open if empty
#



my $InvFile = "InvFile.txt";
my $NewInvFile = "NewInvFile.txt";
@inventory = (1,2,3); #add inventory

print "Welcome to the Toner Inventory System.
To Add toner hit a, to remove toner press r: ";
chomp($choice = <STDIN>);
exit 0 if ($choice eq "");
print "Scan the toner barcode now: ";
chomp($scan = <STDIN>);


#open(FILEREAD, "< $InvFile") || die "Inventory File could not be opened! \n";
#while (my $text = <FILEREAD>){
#	chomp($_);
	
	
	if ($choice == "a")
		{
			open(my $sFILEREAD, ">> $InvFile") || die "Inventory File could not be opened! \n";

			print sFILEREAD "$scan\n";
			#push @inventory, "$scan";
			print "$scan was added to the Inventory!";
			print "$sFILEREAD";
			close sFILEREAD;
			exit;
			
		}
	
	elsif ($choice == "r")
		{
			pop @inventory, "$scan";
		}	
	
	else {
			print "Not a valid command";
			exit;
		}
#	}

#close FILEREAD;


#print "\n bar code = $scan \n choice was = $choice";
#print "\n @inventory";
#exit;
