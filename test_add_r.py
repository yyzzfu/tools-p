import json

import requests

all_company_info = {
    "1402": {"username": "sy-kf31@1402", "password": "Qwer1234"},
}


def add_r():
    company = '1402'

    url_token = r"https://b2004.bjmantis.net/sso/oauth/token"
    url_add = r"https://b2008.bjmantis.net/ocs-chat/chat/styleRule/add"

    company_info = all_company_info.get(str(company))

    username = company_info.get("username")
    password = company_info.get("password")
    data_for_token = {"username": username, "password": password, "grant_type": "password_d"}

    headers_for_token = {"Authorization": "Basic bWFudGlzX2NybToxMjM0NTY="}

    s = requests.session()
    headers_for_process = None
    # 登录获取access_token
    try:
        res = s.post(url_token, data=data_for_token, headers=headers_for_token)
        access_token = res.json()['access_token']
        access_token = "Bearer " + access_token
        headers_for_process = {"Authorization": access_token}
        user_agent = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"}
        headers_for_process.update(user_agent)

    except Exception as e:
        print("获取tonken失败")
        raise e

    data_for_add = {"name": "1111111133111", "active": True, "ruleUrlFlag": False, "ruleUrl": "", "ruleWdFlag": True,
                    "ruleWd": "关键词1", "soundFlag": True,
                    "soundUrl": "https://probe.bjmantis.net/chat/sysAudio/defaultChat.mp3", "flickerFlag": True,
                    "flickerColor": "#000000", "chatColorFlag": True, "chatColor": "#f44e3b"}
    data_for_add_d = json.dumps(data_for_add)
    print(data_for_add_d)
    try:
        res = s.post(url_add, json=data_for_add_d, headers=headers_for_process)
        print(res.text)
    except Exception as e:
        print(e)
        print("调用新增接口失败")


add_r()
