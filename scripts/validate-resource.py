import sys
from frictionless import Inquiry

def validate_resource (resource):

  inquiry = Inquiry({'tasks': [
    {'source': f'data/{resource}.csv.gz'},
    {'source': f'schemas/{resource}.yaml'}
]})
  inquiry.to_yaml(f'inquiries/{resource}.inquiry.yaml')

if __name__ == '__main__':
    validate_resource(sys.argv[1])