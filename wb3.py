import requests
import websocket
import time

from locust import events, TaskSet, task, User, constant_pacing
# from mix_loadtest.log import log_config

# log = log_config(f_level=logging.INFO, c_level=logging.INFO, out_path='../../../logs',
#                  filename='tst_wb_log2', fix=True)[0]


class WebSocketClient(object):

    def __init__(self, host):
        self.host = host
        self.ws = websocket.WebSocket()
        self.name = "wsTest"

    def record_result(self, response_time, response_length=0, exception_msg=None):
        self.name = "wsTest"
        if exception_msg:
            events.request_failure.fire(request_type="WS", name=self.name, response_time=response_time,
                                        exception=exception_msg,
                                        response_length=len(exception_msg))
        else:
            events.request_success.fire(request_type="WS", name=self.name, response_time=response_time,
                                        response_length=response_length)

    def connect(self, burl, request_name='urlweb'):
        self.name = request_name
        start_time = time.time()
        try:
            self.conn = self.ws.connect(url=burl)
        except websocket.WebSocketTimeoutException as e:
            total_time = int((time.time() - start_time) * 1000)
            self.record_result(response_time=total_time, exception_msg=e)
        else:
            total_time = int((time.time() - start_time) * 1000)
            self.record_result(response_time=total_time)
        # log.info(f'{request_name} connect success ....')
        return self.conn

    def recv(self):
        return self.ws.recv()

    def send(self, msg):
        self.ws.send(msg)

    def rec_msg(self, expect_str=None, time_out=500, forever=False, time_out_per=60, run_user=None):
        pass


class WSUser(User):
    abstract = True

    def __init__(self, *args, **kwargs):
        super(WSUser, self).__init__(*args, **kwargs)
        self.client = WebSocketClient(self.host)


class SupperSC(WSUser):
    host = '192.168.1.1:10219'  # 待测主机
    wait_time = constant_pacing(1)  # 单个用户执行间隔时间

    def get_data(self):
        time_str1 = str(int(time.time() * 1000))
        url_http_1 = f"https://demo2.bjmantis.net:13014/socket.io/1/?t={time_str1}"
        res1 = requests.get(url_http_1)
        data1 = res1.text.split(':')[0]
        return data1

    def on_start(self):
        self.data1 = self.get_data()

    @task
    def test_wb(self):
        host = self.client.host
        url = f'wss://demo2.bjmantis.net:13014/socket.io/1/websocket/{self.data1}'
        self.client.connect(url)
        print(self.client.recv())
        # wb数据send/rec 及逻辑
        self.client.send('hahahah')