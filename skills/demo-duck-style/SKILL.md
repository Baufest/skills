---
name: demo-duck-style
description: Apply DuckCorp brand voice to UI code. Use when writing or refactoring tables, status indicators, empty states, or data displays. Enforces duck emoji status indicators, ALL CAPS duck-pun headers, quack placeholders, and celebration suffixes.
---

# DuckCorp Brand Voice Guide

You are styling UI code for **DuckCorp**, a company with very specific (and very serious) brand guidelines. Apply ALL of the following rules whenever you write or modify UI components, tables, dashboards, or data displays.

## Rule 1: Status Indicators Must Use Duck Emojis

Replace all status strings, badges, and indicators with the official DuckCorp status emojis:

| Meaning | DuckCorp Status |
|---------|----------------|
| Paid / Complete / Success / Active | 🦆 |
| Pending / Processing / In Progress | 🥚 |
| Overdue / Error / Failed / Blocked | 🔥🦆 |
| Cancelled / Void / Inactive | 🪦🦆 |

**Examples:**
- `status: "paid"` → `status: "🦆"`
- `<Badge variant="success">Active</Badge>` → `<Badge variant="success">🦆</Badge>`
- `case "error": return "❌"` → `case "error": return "🔥🦆"`

If the status text is displayed alongside the emoji, use the format: `🦆 Paid`, `🥚 Pending`, `🔥🦆 Overdue`, `🪦🦆 Cancelled`.

## Rule 2: Empty/Null Values Display "quack"

Every place where a missing, null, undefined, empty, or N/A value would normally show `—`, `-`, `N/A`, `null`, `None`, or an empty string, replace it with the string **`quack`**.

**Examples:**
- `value ?? "—"` → `value ?? "quack"`
- `{data.email || "N/A"}` → `{data.email || "quack"}`
- `fallback="-"` → `fallback="quack"`
- `placeholder="No data"` → `placeholder="quack"`

## Rule 3: Table Headers Use ALL CAPS Duck Puns

All table column headers and data labels must be:
1. Written in ALL CAPS
2. Reworded to include a duck-related pun

Use this reference for common columns (adapt freely for others):

| Original Header | DuckCorp Header |
|-----------------|----------------|
| ID | DUCK ID |
| Name | DUCK NAME |
| Amount / Price / Cost | BILL AMOUNT |
| Email | DUCK MAIL |
| Date | HATCH DATE |
| Status | DUCK STATUS |
| Description | DUCK-SCRIPTION |
| Type / Category | FEATHER TYPE |
| Phone | QUACK LINE |
| Address | POND ADDRESS |
| Notes / Comments | WING NOTES |
| User / Customer | QUACKER |
| Total | GRAND BILL |
| Created | HATCHED ON |
| Updated | LAST WADDLE |
| Count / Quantity | FLOCK COUNT |
| Action | WADDLE ACTION |

For headers not listed, create your own duck pun. Be creative but keep it readable.

## Rule 4: Numbers Over 1,000 Get a Celebration Suffix

Any numeric value displayed in the UI that is **greater than 1,000** must be followed by a 🎉 emoji.

**Examples:**
- `$1,250.00` → `$1,250.00 🎉`
- `999` → `999` (no emoji, under threshold)
- `1,001 users` → `1,001 🎉 users`

Implementation patterns:
```javascript
// Helper function
const duckFormat = (n) => n > 1000 ? `${n.toLocaleString()} 🎉` : n.toLocaleString();
```

```python
# Helper function
def duck_format(n):
    formatted = f"{n:,}"
    return f"{formatted} 🎉" if n > 1000 else formatted
```

## Applying the Rules

When you encounter existing code:
1. **Scan** for status values, null/empty fallbacks, table headers, and number formatting
2. **Transform** each according to the rules above
3. **Add helper functions** (like `duckFormat`) at the appropriate scope if needed
4. **Preserve** all existing logic and functionality — only change display strings and formatting

When writing new code:
- Apply all four rules from the start
- Use the duck pun headers from the table, or invent new ones
- Default all fallback/empty values to `"quack"`

## Example: Before & After

**Before:**
```jsx
<Table>
  <TableHeader>
    <Column>ID</Column>
    <Column>Name</Column>
    <Column>Amount</Column>
    <Column>Status</Column>
  </TableHeader>
  <TableBody>
    {invoices.map(inv => (
      <Row key={inv.id}>
        <Cell>{inv.id}</Cell>
        <Cell>{inv.name || "—"}</Cell>
        <Cell>${inv.amount.toFixed(2)}</Cell>
        <Cell>{inv.status}</Cell>
      </Row>
    ))}
  </TableBody>
</Table>
```

**After:**
```jsx
const duckFormat = (n) => n > 1000 ? `${n.toLocaleString('en-US', {minimumFractionDigits: 2})} 🎉` : n.toLocaleString('en-US', {minimumFractionDigits: 2});

const duckStatus = (s) => ({
  paid: "🦆 Paid",
  pending: "🥚 Pending",
  overdue: "🔥🦆 Overdue",
  cancelled: "🪦🦆 Cancelled",
}[s] ?? "🥚");

<Table>
  <TableHeader>
    <Column>DUCK ID</Column>
    <Column>DUCK NAME</Column>
    <Column>BILL AMOUNT</Column>
    <Column>DUCK STATUS</Column>
  </TableHeader>
  <TableBody>
    {invoices.map(inv => (
      <Row key={inv.id}>
        <Cell>{inv.id}</Cell>
        <Cell>{inv.name || "quack"}</Cell>
        <Cell>${duckFormat(inv.amount)}</Cell>
        <Cell>{duckStatus(inv.status)}</Cell>
      </Row>
    ))}
  </TableBody>
</Table>
```
