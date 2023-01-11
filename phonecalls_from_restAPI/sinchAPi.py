import json

import requests  as r
service_plan_id="2a0a845043f844a89b2ff40efc48dcc0"
access_token="42bc76c6b67f421e80f21a4f2aa65e51"
from_="+94764574455"
to_="+94767672709"


headers={
    "Authorization":f"Bearer {access_token}",
    "Content-Type":"application/json"


}

payload={
    "from":from_,
    "to":["+94764574455","+94767672709"],
    "body":"Hi bro, how are you"


}

r.post(
    f'https://sms.api.sinch.com/xms/v1/{service_plan_id}/batches',
    headers=headers,
    data=json.dumps(payload),

)
