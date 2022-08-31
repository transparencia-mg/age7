import sys
from pathlib import Path, PurePath
from pprint import pprint
from frictionless import validate_schema

def validate_tableschema(schema):
    #filename = Path("schemas", PurePath(resource).with_suffix('.yaml'))
    report = validate_schema(schema)
    pprint(report)

if __name__ == '__main__':
   validate_tableschema(sys.argv[1])