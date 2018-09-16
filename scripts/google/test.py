#!/bin/python

import gapi
import json

google = gapi.GAPI()
google.enable_gdrive()
print(json.dumps(google.gdrive.files().list().execute(), indent=4))
