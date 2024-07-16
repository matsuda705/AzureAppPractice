FROM python:3.12.4-bullseye

WORKDIR /usr/src/python
COPY WebUI/requirements.txt ./
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

WORKDIR /usr/src
COPY WebUI/ ./

EXPOSE 8080 2222

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=8080"]