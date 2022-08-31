import os
import json

path = 'logs/validate'
folder = os.fsencode(path)

# Iterate over all reports file in logs/validate folder
for file in os.listdir(folder):
    filename = os.fsdecode(file)
    # build report's file path
    file_path = f'{path}/{filename}'
    with open(file_path, 'r', encoding='utf8') as json_file:
    	# Load file content as python dictionary (json file to dictionary)
    	if file_path != 'logs/validate/.gitkeep' and file_path != 'logs/validate/failed_reports.json':
	    	file_content = json.load(json_file)
	    	# Check valid property to see if validation passed
	    	if file_content['valid'] == False:
	    		resource_name = filename.split('.')[0]
	    		os.system(f'echo Rerun logs/validate/{filename} >> logs/check_validation.txt')
	    		os.system(f'dtamg-py etl-make validate -r {resource_name} > logs/validate/{filename}')