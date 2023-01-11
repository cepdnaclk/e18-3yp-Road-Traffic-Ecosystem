import vonage

client = vonage.Client(
    application_id="ad9a0d67-8b90-482f-9b52-efd96b36c213",
    private_key="venv/private.key",

)


voice = vonage.Voice(client)

response = voice.create_call({
    'to': [{'type': 'phone', 'number': "94767672709"}],
    'from': {'type': 'phone', 'number': "94767672709"},
    'ncco': [{'action': 'talk', 'text': 'This is a text to speech call from Nexmo'}]
})

print(response)
