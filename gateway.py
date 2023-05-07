from flask import Flask, request, jsonify
import json
from main_functions import get_dpp_history, get_dpp_first, get_dpp_last, add_dpp, update_dpp
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

#
# These are the endpoints for the frontend to call, but in real project data will come IoT devices and will be processed
#
@app.route("/get_dpp_history", methods=["POST"])
def get_dpp_history_by_id():
    json_data = request.get_json()
    dpp = get_dpp_history(json_data["id"])
    return jsonify(dpp)

@app.route("/get_dpp_first", methods=["POST"])
def get_dpp_first():
    json_data = request.get_json()
    dpp = get_dpp_first(json_data["id"])
    return jsonify(dpp)

@app.route("/get_dpp_last", methods=["POST"])
def get_dpp_last():
    json_data = request.get_json()
    dpp = get_dpp_last(json_data["id"])
    return jsonify(dpp)

@app.route("/create_dpp", methods=["POST"])
def create_dpp():
    json_data = request.get_json()
    dpp = add_dpp(json_data["companyName"], json_data["productType"], json_data["productDetail"], json_data["manucaftureDate"])
    print(dpp)
    return "success"

@app.route("/update_dpp", methods=["POST"])
def update_dpp_web():
    json_data = request.get_json()
    dpp = update_dpp(json_data["dpp_identifier"], json_data["companyName"], json_data["productType"], json_data["productDetail"], json_data["manucaftureDate"])
    print(dpp)
    return "success"

app.run()
