import os
from fastapi import FastAPI, Request, Response
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates


app = FastAPI()
app.mount("/s", StaticFiles(directory="static"))
templates = Jinja2Templates(directory="templates")


@app.get("/", response_class=HTMLResponse)
async def index(request: Request):
    return templates.TemplateResponse(request=request, name="index.jinja", context={
        'foo': 'Stahp!',
        'port': os.getenv('PORT', '1234'),
    })


@app.get('/healthz')
def healthz():
    return Response(status_code=200)