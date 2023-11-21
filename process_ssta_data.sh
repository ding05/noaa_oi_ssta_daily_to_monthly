#!/bin/bash

# Use the CDO commands to merge multi-year daily SSTA 
# NetCDF files into one monthly SSTA NetCDF file.
# Be sure no NetCDF file is corrupted.

# Define the start and end year.
START_YEAR=1981
END_YEAR=2023

# Array to hold the names of the monthly average files.
MONTHLY_FILES=()

# Loop through each year.
for YEAR in $(seq $START_YEAR $END_YEAR); do
    # Define the input and output file names.
    INPUT_FILE="sst.day.anom.${YEAR}.nc"
    OUTPUT_FILE="sst.month.anom.${YEAR}.nc"

    # Calculate the monthly mean for the year.
    cdo monmean $INPUT_FILE $OUTPUT_FILE

    # Add the output file to the array.
    MONTHLY_FILES+=($OUTPUT_FILE)
done

# Merge the monthly files into one.
FINAL_OUTPUT="sst.month.anom.1981_2023.nc"
cdo mergetime "${MONTHLY_FILES[@]}" $FINAL_OUTPUT

echo "Monthly averages merged into $FINAL_OUTPUT."