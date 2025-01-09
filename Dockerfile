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

#HEALTHCHECK --start-period=30s --interval=30s --retries=5 --timeout=10s \
#    CMD curl -f http://localhost:8000/healthz || exit 1


EXPOSE 8000
#CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "app.main:app", "--bind", "0.0.0.0:8080"]
#CMD ["gunicorn", "main:app", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "-b", "0.0.0.0:$PORT"]
CMD ["gunicorn", "main:app", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "-b", "0.0.0.0:8000"]
