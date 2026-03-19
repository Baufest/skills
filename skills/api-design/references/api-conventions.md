# API Conventions Reference

Detailed conventions for HTTP methods, status codes, naming, and common patterns.

## HTTP Methods

| Method | Semantics | Idempotent | Request Body | Success Code |
|--------|-----------|-----------|-------------|-------------|
| GET | Read a resource or list | Yes | No | 200 |
| POST | Create a new resource | No | Yes | 201 |
| PUT | Replace a resource entirely | Yes | Yes | 200 |
| PATCH | Partially update a resource | No* | Yes | 200 |
| DELETE | Remove a resource | Yes | No | 204 |

*PATCH with JSON Merge Patch is idempotent. PATCH with JSON Patch is not necessarily.

### Method Selection Rules

- **GET** must never have side effects. It must be safe to retry, cache, and prefetch.
- **POST** is for creation. Return the created resource with a `Location` header pointing to the new resource URL.
- **PUT** replaces the entire resource. The client must send all fields. Missing fields are set to defaults or null.
- **PATCH** updates only the provided fields. Use JSON Merge Patch (`application/merge-patch+json`) for simplicity. Use JSON Patch (`application/json-patch+json`) only when you need array manipulation.
- **DELETE** is idempotent — deleting an already-deleted resource returns 204, not 404. This prevents race conditions.

## HTTP Status Codes

### Success (2xx)

| Code | When to Use |
|------|-------------|
| 200 OK | GET, PUT, PATCH succeeded. Return the resource. |
| 201 Created | POST succeeded. Return the created resource + `Location` header. |
| 202 Accepted | Request accepted for async processing. Return a status/job URL. |
| 204 No Content | DELETE succeeded. No response body. |

### Client Errors (4xx)

| Code | When to Use |
|------|-------------|
| 400 Bad Request | Malformed request syntax, invalid JSON, type errors. |
| 401 Unauthorized | Missing or invalid authentication credentials. |
| 403 Forbidden | Authenticated but not authorized for this action. |
| 404 Not Found | Resource does not exist. Also use for unauthorized access to hide resource existence. |
| 409 Conflict | State conflict — duplicate creation, version mismatch, concurrent edit. |
| 422 Unprocessable Entity | Valid JSON but fails business validation (e.g., email format, required field missing). |
| 429 Too Many Requests | Rate limited. Include `Retry-After` header. |

### Server Errors (5xx)

| Code | When to Use |
|------|-------------|
| 500 Internal Server Error | Unexpected server failure. Log the details, return a generic error to the client. |
| 502 Bad Gateway | Upstream service returned an invalid response. |
| 503 Service Unavailable | Server is overloaded or in maintenance. Include `Retry-After` header. |
| 504 Gateway Timeout | Upstream service timed out. |

### Status Code Rules

1. **Never return 200 with an error body.** If something failed, use a 4xx or 5xx code.
2. **Use 422 for validation errors, not 400.** 400 is for malformed requests (bad JSON). 422 is for valid requests that fail business rules.
3. **Use 409 for conflicts.** Duplicate email on registration, version mismatch on update, concurrent edit collision.
4. **Always include `Retry-After`** with 429 and 503 responses.

## Naming Conventions

### URL Paths

- Use `kebab-case`: `/user-profiles`, not `/userProfiles` or `/user_profiles`
- Use plural nouns for collections: `/orders`, not `/order`
- Use the resource ID as a path segment: `/orders/{orderId}`
- Limit nesting to one level: `/orders/{orderId}/items`
- For actions that don't map to CRUD, use a verb sub-resource: `POST /orders/{id}/cancel`

### JSON Fields

- Use `camelCase`: `firstName`, `createdAt`, `orderTotal`
- Use `ISO 8601` for dates: `"2025-03-15T14:30:00Z"`
- Use `string` for IDs, even if they're numeric underneath
- Use `null` for absent optional fields, not empty strings or `0`

### Enum Values

- Use `UPPER_SNAKE_CASE`: `PENDING`, `IN_PROGRESS`, `COMPLETED`
- Define all values in the OpenAPI `enum` array
- Never use integer enums — strings are self-documenting

### Operation IDs

- Format: `verbNoun` in `camelCase`
- Verb vocabulary: `list`, `get`, `create`, `update`, `delete`, `search`, `cancel`, `approve`
- Examples: `listOrders`, `getUser`, `createInvoice`, `updatePaymentMethod`, `deleteWebhook`

## Common Patterns

### Pagination

**Cursor-based (recommended for most cases):**

```
GET /items?cursor={opaque_string}&limit=25

Response:
{
  "data": [...],
  "pagination": {
    "nextCursor": "eyJpZCI6MTQ4fQ",
    "hasMore": true
  }
}
```

**Offset-based (for small, stable datasets):**

```
GET /items?offset=50&limit=25

Response:
{
  "data": [...],
  "pagination": {
    "total": 243,
    "offset": 50,
    "limit": 25
  }
}
```

### Filtering

Use query parameters with clear names:

```
GET /orders?status=SHIPPED&customerId=usr_123&createdAfter=2025-01-01&createdBefore=2025-03-01
```

Rules:
- One parameter per filter field
- Use `After`/`Before` suffixes for date ranges
- Use comma-separated values for multi-select: `?status=SHIPPED,DELIVERED`

### Sorting

Use a `sort` parameter with field names. Prefix with `-` for descending:

```
GET /orders?sort=-createdAt,totalAmount
```

### Bulk Operations

For operations on multiple resources, use a batch endpoint:

```
POST /orders/batch
{
  "operations": [
    { "method": "update", "id": "ord_123", "body": { "status": "CANCELLED" } },
    { "method": "update", "id": "ord_456", "body": { "status": "CANCELLED" } }
  ]
}
```

Return per-item results so partial failures are visible.

### Async Operations

For long-running operations, return 202 with a job URL:

```
POST /reports/generate → 202 Accepted
Location: /jobs/job_789

GET /jobs/job_789 → { "status": "RUNNING", "progress": 45 }
GET /jobs/job_789 → { "status": "COMPLETED", "result": { "url": "/reports/rpt_012" } }
```

## OpenAPI Best Practices

1. **Use `$ref` for all shared schemas.** Define once in `components/schemas`, reference everywhere.
2. **Separate read vs write schemas.** `User` (read, includes `id`, `createdAt`) vs `CreateUserRequest` (write, no `id`).
3. **Use `oneOf`/`discriminator` for polymorphism.** Not `additionalProperties: true`.
4. **Set `additionalProperties: false`** on request bodies to catch typos.
5. **Use `format` hints.** `string` + `format: email`, `format: uri`, `format: date-time`, `format: uuid`.
6. **Document auth with `securitySchemes`.** Bearer token, API key, OAuth2 — define them properly.
7. **Add `description` to every field.** Generated docs are only as good as your descriptions.
