FROM python:3.12.7-slim-bookworm
LABEL authors="enchance"


ENV PIP_ROOT_USER_ACTION=ignore

RUN apt update && apt upgrade -y \
    && apt install -y curl tree neovim

WORKDIR /root
COPY bashrc/ .

WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip --no-cache-dir --upgrade -r requirements.txt
COPY . .


EXPOSE 8000
CMD ["gunicorn", "main:app", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "-b", "0.0.0.0:$PORT"]
