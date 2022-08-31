import os
import datetime
import json
from datetime import datetime
import frictionless

path = 'logs/validate'
folder = os.fsencode(path)
failed_tasks = []
errors = 0
now = datetime.now()
formated_date = now.strftime("%d/%m/%Y %H:%M:%S")

reports_content = {
	"version": frictionless.__version__,
	"formated_date": formated_date,
	"time": 0.01,
	"errors": [],
	"tasks": [],
	"stats": {
	    "errors": 0,
	    "tasks": 0
	  	},
  	"valid": True
}

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
	    		# Add Failed validations to failed_tasks list previosly created
	    		failed_tasks.append(file_content['tasks'][0])
	    		errors += len(file_content['tasks'][0]['errors'])
# Add failed valitations to failed_reports.json file
if len(failed_tasks) > 0:
	# Iterate over most recenly failed validations		
	reports_content['stats']['errors'] = errors
	reports_content['stats']['tasks'] = len(failed_tasks)
	reports_content['valid'] = False
	for failed_task in failed_tasks:
		reports_content['tasks'].append(failed_task)
	with open(f'{path}/failed_reports.json', 'w') as new_json_file:
		# Write new failed validations on failed_reports.json file
		json.dump(reports_content, new_json_file, ensure_ascii=False, indent=2)
else:
	with open(f'{path}/failed_reports.json', 'w') as new_json_file:
		# Write new failed validations on failed_reports.json file
		json.dump(reports_content, new_json_file, ensure_ascii=False, indent=2)