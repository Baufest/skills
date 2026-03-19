---
name: api-design
description: >-
  Design ergonomic, consistent REST and HTTP APIs that work well with OpenAPI
  and code generators. Use this skill when designing an API, writing an OpenAPI
  spec, reviewing API endpoints, naming resources, choosing HTTP methods,
  structuring request/response bodies, designing pagination, or planning API
  versioning. Also triggers for: "what should this endpoint look like",
  "review my API", "write the OpenAPI spec", "REST design", "API contract",
  "resource naming", "error response format", or "how should I paginate this".
  Do NOT use for GraphQL schema design, gRPC protobuf definitions, database
  schema design (use data-table-design), or general backend architecture
  (use architecture-decision).
license: Apache-2.0
metadata:
  author: baufest
  version: "1.0"
---

# API Design

## Overview

Design REST and HTTP APIs that are consistent, predictable, and generate clean client code through OpenAPI tooling. Good APIs are obvious to consume, hard to misuse, and survive multiple generations of clients.

## When to Use

- Designing new API endpoints or an entire API surface
- Writing or reviewing OpenAPI / Swagger specifications
- Naming resources, choosing HTTP methods, or structuring URLs
- Designing pagination, filtering, sorting, or search
- Choosing error response formats
- Planning API versioning strategy
- Reviewing an existing API for consistency and ergonomics

## Instructions

### Step 1: Clarify the API Context

Gather from the user (skip what's already provided):

1. **What domain / resource(s)?** — What real-world concepts does this API model?
2. **Who are the consumers?** — Internal services, mobile apps, third-party developers, all of the above?
3. **Existing conventions?** — Is this extending an existing API or greenfield?
4. **OpenAPI tooling in use?** — Code generators, documentation tools, SDK generation?
5. **Scale and performance constraints?** — Expected request volume, latency targets, payload sizes?

### Step 2: Apply Resource Design Principles

Follow the conventions in [references/api-conventions.md](references/api-conventions.md). Key principles:

**Resources, not actions.** URLs identify nouns, not verbs. HTTP methods express the action.

```
GOOD:  POST /orders          (create an order)
BAD:   POST /createOrder
```

**Plural nouns for collections.** Singular for singletons.

```
GET  /users           → list users
GET  /users/{id}      → get one user
POST /users           → create a user
GET  /users/me        → current user (singleton)
```

**Consistent naming.** Use `kebab-case` for URL paths, `camelCase` for JSON fields, `UPPER_SNAKE_CASE` for enum values. Never mix conventions within an API.

**Flat over nested.** Limit URL nesting to one level of sub-resources. Beyond that, promote to top-level with a filter.

```
GOOD:  GET /orders/{id}/items
AVOID: GET /users/{uid}/orders/{oid}/items/{iid}/adjustments
USE:   GET /adjustments?itemId={iid}
```

### Step 3: Design Request/Response Shapes

**Be explicit about types.** Every field should have an unambiguous type in the OpenAPI spec. Avoid `object` without properties. Avoid `string` for dates — use `format: date-time`.

**Envelope responses consistently.** Choose one pattern and use it everywhere:

```json
{
  "data": { ... },
  "meta": { "requestId": "abc-123" }
}
```

Or return the resource directly (simpler, works well with code generators):

```json
{
  "id": "usr_123",
  "name": "Ada Lovelace",
  "email": "ada@example.com"
}
```

Pick one. Do not mix.

**Use typed IDs.** Prefix IDs with the resource type for debuggability: `usr_123`, `ord_456`, `inv_789`. Use `string` type in OpenAPI, not `integer` — this future-proofs against ID format changes.

**Pagination.** Use cursor-based pagination for large or real-time datasets. Offset-based for small, stable datasets.

```
GET /orders?cursor=eyJpZCI6MTIzfQ&limit=25

Response:
{
  "data": [...],
  "pagination": {
    "nextCursor": "eyJpZCI6MTQ4fQ",
    "hasMore": true
  }
}
```

**Filtering and sorting.** Use query parameters. Keep filter syntax simple — avoid inventing a query language.

```
GET /orders?status=SHIPPED&createdAfter=2025-01-01&sort=-createdAt
```

### Step 4: Design Error Responses

Use a consistent error shape across the entire API. Include enough information for the client to programmatically handle the error AND for a developer to debug it.

```json
{
  "error": {
    "code": "VALIDATION_FAILED",
    "message": "The request body contains invalid fields.",
    "details": [
      {
        "field": "email",
        "issue": "Must be a valid email address.",
        "value": "not-an-email"
      }
    ]
  }
}
```

Rules:
- `code` is a stable, machine-readable string (not the HTTP status code)
- `message` is human-readable, safe to show in UI
- `details` is an array for field-level errors
- Use standard HTTP status codes correctly (see conventions reference)
- 4xx for client errors, 5xx for server errors — never return 200 with an error body

### Step 5: Design for OpenAPI Compatibility

The API should generate a clean, complete OpenAPI spec. Apply these rules:

1. **Every endpoint has an `operationId`.** Use `camelCase`, format as `verbNoun`: `listOrders`, `getUser`, `createInvoice`. These become method names in generated SDKs.
2. **Every request/response body is a named schema.** Use `$ref` to shared components. Never inline complex objects.
3. **Use `enum` for constrained strings.** Status fields, type fields, category fields — define them as enums so generated code gets type safety.
4. **Tag endpoints by resource.** One tag per resource group. Tags become namespaces in generated clients.
5. **Provide `example` values.** Every schema property should have an example. This powers documentation and mock servers.
6. **Use `required` explicitly.** List required fields. Do not rely on consumers guessing.
7. **Distinguish create vs update schemas.** `CreateUser` (all required fields) vs `UpdateUser` (all optional, patch semantics). Do not reuse the same schema for both.

### Step 6: Versioning Strategy

Choose one:

| Strategy | When to Use | Tradeoff |
|----------|-------------|----------|
| URL prefix (`/v1/...`) | Public APIs, multiple major versions coexist | Simple to understand, harder to maintain multiple versions |
| Header (`API-Version: 2025-03-01`) | APIs that evolve incrementally | Cleaner URLs, more complex routing |
| No versioning | Internal APIs with lockstep deployment | Simplest, but breaks if consumers can't update in sync |

Default recommendation: **URL prefix** for external APIs, **header-based date versioning** for APIs that evolve frequently, **no versioning** for internal microservice APIs deployed together.

### Step 7: Review Checklist

Before finalizing, verify:

- [ ] Every resource uses plural nouns in URLs
- [ ] HTTP methods match CRUD semantics (GET reads, POST creates, PUT/PATCH updates, DELETE deletes)
- [ ] All endpoints have unique `operationId` values
- [ ] Request/response schemas are named and referenced via `$ref`
- [ ] Error responses use a consistent shape with machine-readable codes
- [ ] Pagination is implemented for all list endpoints
- [ ] All fields have explicit types, formats, and examples in OpenAPI
- [ ] Enums are used for constrained string values
- [ ] Create and update schemas are separate
- [ ] No breaking changes to existing published endpoints (if extending)

## Output Format

Deliver one or more of:
- An OpenAPI 3.1 YAML specification (preferred)
- A structured endpoint design document with URL, method, request/response shapes, and status codes
- A review with specific findings and recommended fixes

## References

- See [api-conventions.md](references/api-conventions.md) for the full HTTP method and status code reference
