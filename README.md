<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Bricorama Scraper API by Piloterr – scrape Bricorama data as JSON" width="100%"></a>
</p>

# Bricorama Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Bricorama Scraper API** lets you extract public data from Bricorama as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Bricorama Product API** — Read one Bricorama product from its URL.
- **Bricorama Search API** — Search Bricorama by keyword or search URL and page the home-improvement grid.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Bricorama Product API](#bricorama-product-api) | `/v2/bricorama/product` | 1 | Read one Bricorama product from its URL. You get price, brand, and the product details. |
| [Bricorama Search API](#bricorama-search-api) | `/v2/bricorama/search` | 1 | Search Bricorama by keyword or search URL and page the home-improvement grid. |

## Table of contents

- [How it works](#how-it-works)
- [Bricorama Product API](#bricorama-product-api)
- [Bricorama Search API](#bricorama-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Bricorama Product API

Read one Bricorama product from its URL. You get price, brand, and the product details.

`GET | POST https://api.piloterr.com/v2/bricorama/product` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Product URL `/p/{slug}/{ean}`. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/bricorama/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.bricorama.fr/p/perceuse-visseuse-sans-fil-18v/3999991691267",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type BricoramaProduct = {
  ean?: string;
  url?: string;
  name?: string;
  brand?: string;
  price?: number;
  images?: string[];
  currency?: string;
  delivery?: string;
  was_price?: unknown;
  description?: string;
  price_display?: string;
  specifications?: {
    name?: string;
    value?: string;
  }[];
  discount_display?: unknown;
  was_price_display?: unknown;
};

const params = new URLSearchParams({
  "query": "https://www.bricorama.fr/p/perceuse-visseuse-sans-fil-18v/3999991691267",
});

const response = await fetch(`https://api.piloterr.com/v2/bricorama/product?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as BricoramaProduct;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/bricorama/product
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.bricorama.fr/p/perceuse-visseuse-sans-fil-18v/3999991691267"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "ean": "3999991691267",
  "url": "https://www.bricorama.fr/p/perceuse-visseuse-sans-fil-18v/3999991691267",
  "name": "Perceuse visseuse sans fil 18V",
  "brand": "GO/ON",
  "price": 27.9,
  "images": [
    "https://assets-big.cdn-mousquetaires.com/medias/domain11440/media2624/393739-2ftpvnauip-epreview.jpg"
  ],
  "currency": "EUR",
  "delivery": "Retrait en 2h en magasin",
  "was_price": null,
  "description": "Découvrez la perceuse visseuse sans fil 18V de la marque GO/ON, un outil performant et pratique conçu pour faciliter tous vos travaux de …",
  "price_display": "27,90 €",
  "specifications": [
    {
      "name": "Marque",
      "value": "GO/ON"
    },
    {
      "name": "Éclairage intégré",
      "value": "Non"
    }
  ],
  "discount_display": null,
  "was_price_display": null
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `ean` | string |  |
| `url` | string |  |
| `name` | string |  |
| `brand` | string |  |
| `price` | number |  |
| `images` | string[] |  |
| `currency` | string |  |
| `delivery` | string |  |
| `was_price` | object |  |
| `description` | string |  |
| `price_display` | string |  |
| `specifications[]` | object[] |  |
| `specifications[].name` | string |  |
| `specifications[].value` | string |  |
| `discount_display` | object |  |
| `was_price_display` | object |  |

## Bricorama Search API

Search Bricorama by keyword or search URL and page the home-improvement grid.

`GET | POST https://api.piloterr.com/v2/bricorama/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Keyword, or a Bricorama /search URL. |
| `page` | number | — | Page from 1. Sent as ?page= on the listing. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/bricorama/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "perceuse",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type BricoramaSearch = {
  results?: {
    ean?: string;
    url?: string;
    name?: string;
    brand?: string;
    image?: string;
    price?: number;
    seller?: unknown;
    currency?: string;
    delivery?: string;
    position?: number;
    was_price?: unknown;
    availability?: string;
    price_display?: string;
    discount_display?: unknown;
    was_price_display?: unknown;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: unknown;
    total_results?: unknown;
  };
};

const params = new URLSearchParams({
  "query": "perceuse",
});

const response = await fetch(`https://api.piloterr.com/v2/bricorama/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as BricoramaSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/bricorama/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "perceuse"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "ean": "3999991691267",
      "url": "https://www.bricorama.fr/p/perceuse-visseuse-sans-fil-18v/3999991691267",
      "name": "Perceuse visseuse sans fil 18V",
      "brand": "GO/ON",
      "image": "https://assets-big.cdn-mousquetaires.com/medias/domain11440/media2624/393739-2ftpvnauip-large.jpg",
      "price": 27.9,
      "seller": null,
      "currency": "EUR",
      "delivery": "Retrait en 2h en magasin",
      "position": 1,
      "was_price": null,
      "availability": "En stock selon magasin",
      "price_display": "27,90 €",
      "discount_display": null,
      "was_price_display": null
    }
  ],
  "pagination": {
    "next": "https://www.bricorama.fr/search?q=perceuse&page=2",
    "page": 1,
    "per_page": 48,
    "total_pages": null,
    "total_results": null
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].ean` | string |  |
| `results[].url` | string |  |
| `results[].name` | string |  |
| `results[].brand` | string |  |
| `results[].image` | string |  |
| `results[].price` | number |  |
| `results[].seller` | object |  |
| `results[].currency` | string |  |
| `results[].delivery` | string |  |
| `results[].position` | integer |  |
| `results[].was_price` | object |  |
| `results[].availability` | string |  |
| `results[].price_display` | string |  |
| `results[].discount_display` | object |  |
| `results[].was_price_display` | object |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | object |  |
| `pagination.total_results` | object |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Product | Search |
|---|---|---|
| cURL (Bash) | [`product`](examples/curl/product.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`product`](examples/php/product.php) | [`search`](examples/php/search.php) |
| C# | [`product`](examples/csharp/Product.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`product`](examples/go/product.go) | [`search`](examples/go/search.go) |
| Java | [`product`](examples/java/ProductExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`product`](examples/ruby/product.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`product`](examples/nodejs/product.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Bricorama plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Bricorama?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/bricorama/product` **1**, `/v2/bricorama/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Bricorama API return?

Each endpoint returns structured JSON: **Bricorama Product** — `ean`, `url`, `name`, `brand`, `price`, `images`; **Bricorama Search** — `results[]`, `results[].ean`, `results[].url`, `results[].name`, `results[].brand`, `results[].image`.

### How do I paginate Bricorama results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Bricorama is a trademark of its respective owner. This repository is not affiliated with or endorsed by Bricorama. Examples are released under the MIT license.</sub>
