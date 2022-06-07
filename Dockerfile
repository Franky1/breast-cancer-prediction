FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_DEFAULT_TIMEOUT=120 \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

# we probably need build tools?
RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
    gcc \
    g++ \
    build-essential \
    python3-dev

WORKDIR /app
COPY requirements.txt requirements.txt

# if we have a packages.txt, install it
# COPY packages.txt packages.txt
# RUN xargs -a packages.txt apt-get install --yes

RUN pip install --no-cache-dir --upgrade -r requirements.txt

EXPOSE 8501

COPY . .

CMD ["streamlit", "run", "Prediction.py"]

# docker build --progress=plain --tag cancer:latest .
# docker run -ti -p 8501:8501 --rm cancer:latest /bin/bash
# docker run -ti -p 8501:8501 --rm cancer:latest
# docker run -ti -p 8501:8501 -v ${pwd}:/app --rm cancer:latest
# docker run -ti -p 8501:8501 -v ${pwd}:/app --rm cancer:latest /bin/bash