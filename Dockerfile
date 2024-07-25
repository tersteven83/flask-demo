FROM python:3.9.19

WORKDIR /usr/src/app

COPY . .
RUN python3 -m venv .venv
RUN . .venv/bin/activate
RUN pip install -e .
RUN flask --app flaskr init-db

EXPOSE 5000

CMD [ "flask", "--app", "flaskr", "run" ]

LABEL author="steevi83@proton.me"