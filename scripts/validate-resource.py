import os
import sys
import json
from frictionless import Package
from frictionless import validate_resource
from pprint import pprint

def resource_validation(resource_name):
  package = Package('datapackage.json')
  resource = package.get_resource(resource_name)
  report = validate_resource(resource)
  json.dump(report, sys.stdout)
  
if __name__ == '__main__':
    resource_validation(sys.argv[1])
