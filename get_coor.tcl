#####Script developed by Kunal Rai#########
##for more detail read README####
#upload system psf 
mol new lipid_aqp_wi.psf
#upload trajectory file
mol addfile 22jan.dcd waitfor all
# Define the atom selection here
set sel [atomselect top "residue 34649"]

# Open the output file for writing
set outfile [open "frame_z_data.txt" w]

# Write the header to the file
puts $outfile "frame z"

# Loop over all frames in the trajectory
set num_frames [molinfo top get numframes]
for {set frame 0} {$frame < $num_frames} {incr frame} {
    # Set the current frame
    animate goto $frame
    
    # Update the atom selection
    $sel frame $frame
    
    # Get the z-coordinate of the center of mass of the selected atoms
    set z_coord [lindex [$sel get {z}] 3]
    
    # Write the frame number and z-coordinate to the file
    puts $outfile "$frame $z_coord"
}

# Close the output file
close $outfile

# Delete the atom selection
$sel delete

puts "Data has been written to frame_z_data.txt"
quit
