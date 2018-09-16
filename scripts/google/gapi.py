#!/bin/python

# Authors: Travis Gall
# Description: Tools to help with Google API use and development
# Special Thanks: Google

# Imports {{{1
# Standard {{{2
import decimal
import httplib2
import os
import requests

# Google API {{{2
from apiclient.discovery import build
from apiclient.http import MediaFileUpload
from oauth2client.file import Storage

HOME_PATH = '/home/travis'

# GAPI {{{1
class GAPI(object):
# Variables {{{2

# Functions {{{2
# __init__ {{{3
    def __init__(self):
        self.gdrive = None

# gapi {{{3
    def gapi(self, scopes):
        CLIENT_PATH = os.path.join(HOME_PATH, '.config/google')
        CLIENT_FILE = 'travis.gall.json'
        APPLICATION_NAME = 'Drive API Python Quickstart'

        # Ensure directory exists
        if not os.path.exists(CLIENT_PATH): os.makedirs(CLIENT_PATH)
        cred_path = os.path.join(CLIENT_PATH, CLIENT_FILE)
        #os.system("touch %s" % cred_path)
        open(cred_path, 'a').close()

        # Create credentials from file
        store = Storage(cred_path)
        creds = store.get()

        # Invalid credentials file
        if not creds or creds.invalid:
            flow = client.flow_from_clientsecrets(cred_path, scopes)
            flow.user_agent = APPLICATION_NAME
            creds = tools.run_flow(flow, store, flags)

        # Authorize credentials file
        http = creds.authorize(httplib2.Http())

        # Valid api object found or created
        return build('drive', 'v3', credentials=creds)

# enable_gdrive {{{3
    def enable_gdrive(self):
        self.gdrive = self.gapi('https://www.googleapis.com/auth/drive')

# upload_gui {{{3
    def upload_gui(self):
        Tk().withdraw() # Pop-up window only
        file_name = askopenfilename()
        return upload(self, file_name).get('id')

# upload {{{3
    def upload(self, file_name):
        # Request hash to tell the google API what we're giving it
        base_name = os.path.basename(file_name)
        body = {'name': base_name}

        # Upload file to google drive return Google id
        media = MediaFileUpload(file_name)
        return self.gdrive.files().create(body=body,
                media_body=media).execute()

# delete_file {{{3
    def delete_file(self, file_id):
        self.gdrive.files().delete(fileId=file_id).execute()

# download_link {{{3
    def download_link(id, destination='./'):
        def get_confirm_token(response):
            for key, value in response.cookies.items():
                if key.startswith('download_warning'):
                    return value

            return None

        def save_response_content(response, destination):
            # Constants
            CHUNK_SIZE = 512

            # Variables
            counter = 0
            downloaded = 0
            print(str(response.headers.get('content-length')))
            length = int(response.headers.get('content-length'))

            # Configuration
            getcontext().prec = 2
            getcontext().rounding = ROUND_DOWN

            print("File Size: " + str(length))
            print("CHUNK_SIZE: " + str(CHUNK_SIZE))

            with open(destination, "wb") as f:
                for chunk in response.iter_content(CHUNK_SIZE):
                    if chunk: # filter out keep-alive new chunks
                        counter+=1
                        downloaded = downloaded + CHUNK_SIZE if downloaded + CHUNK_SIZE < length else length
                        percent = Decimal(downloaded) / Decimal(length) * 100
                        print("count " + str(counter) + "/" + str(int(length/CHUNK_SIZE) + 1) + " " + str(downloaded) + "/" + str(length) + " " + str('%.0f' %percent) + "%", end="\r")
                        f.write(chunk)

# list_folders {{{3
    def list_folders(self, parent_id, level=1):
        query = "'" + parent_id + "' in parents and mimeType='application/vnd.google-apps.folder'"
        response = self.gdrive.files().list(q=query,
                spaces='drive',
                fields='nextPageToken, files(name, id)').execute()
        #msgbox = gdrive.MessageBox(response)
        for folder in response.get('files', []):
            print('%i-%s (%s)' % (level, folder.get('name'), folder.get('id')))
            #list_folders(service, folder.get('id'), level+1)

# foler_struct {{{3
    """
    def print_files_in_folder(service, folder_id):
        page_token = None
        while True:
            try:
                param = {}
                if page_token:
                    param['pageToken'] = page_token
                children = service.children().list(
                        folderId=folder_id, **param).execute()

                for child in children.get('items', []):
                    print('File Id: %s' % child['id'])
                page_token = children.get('nextPageToken')
                if not page_token:
                    break
            except errors.HttpError:
                print('An error occurred: %s' % error)
                break
    """
class Certification(object):
    def __init__(self, scopes):
        self.api = self.gapi(scopes)
    
    def gapi(self, scopes):
        CLIENT_PATH = os.path.join(HOME_PATH, '.config/google')
        CLIENT_FILE = 'travis.gall.json'
        APPLICATION_NAME = 'Drive API Python Quickstart'

        # Ensure directory exists
        if not os.path.exists(CLIENT_PATH): os.makedirs(CLIENT_PATH)
        cred_path = os.path.join(CLIENT_PATH, CLIENT_FILE)
        #os.system("touch %s" % cred_path)
        open(cred_path, 'a').close()

        # Create credentials from file
        store = Storage(cred_path)
        creds = store.get()

        # Invalid credentials file
        if not creds or creds.invalid:
            flow = client.flow_from_clientsecrets(cred_path, scopes)
            flow.user_agent = APPLICATION_NAME
            creds = tools.run_flow(flow, store, flags)

        # Authorize credentials file
        http = creds.authorize(httplib2.Http())

        # Valid api object found or created
        return build('drive', 'v3', credentials=creds)

class GDrive(object):
    def __init__(self):
        gdrive = self.gdrive = Certification('https://www.googleapis.com/auth/drive').api

    def upload_file(self, file_name):
        # Request hash to tell the google API what we're giving it
        base_name = os.path.basename(file_name)
        body = {'name': base_name}

        # Upload file to google drive return Google id
        media = MediaFileUpload(file_name)
        return self.gdrive.files().create(body=body,
                media_body=media).execute()

    def update_file(self, file_id, file_name):
        self.gdrive.files().update(file_id,
                file_name).execute()
