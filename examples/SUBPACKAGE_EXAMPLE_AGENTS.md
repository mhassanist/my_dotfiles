# Engine Sub-Package Invariants

## Context Inheritance

Apply all general git and tooling boundaries from `../../AGENTS.md`. In addition, strictly enforce the following engine-level overrides.

## Performance & Style Overrides

- **No Floating-Point Money Calculations:** All financial and token units must be represented as `BigInt` or scaled integers (cents / base points). Never use standard JavaScript `number` for currency.
- **Zero External Runtime Dependencies:** Do not add entries to `dependencies` in `package.json`. Everything in this sub-package must be implemented using pure native TypeScript / Node primitives.

## Few-Shot Formatting Invariants

Do not split arithmetic logic into micro-helper functions. Keep calculations inline and typed:

```typescript
// Correct: Explicit inline math with BigInt scaling
export function calculateSettlement(
  principal: bigint,
  rateBps: bigint,
): bigint {
  const scaledRate = rateBps * 100n;
  return (principal * scaledRate) / 10_000n;
}

// Incorrect: Using floating-point math or abstract helper chains
export function calculateSettlement(principal: number, rate: number): number {
  return round(applyRate(principal, rate)); // FORBIDDEN: helper chaining
}
```

## Local Verification

Before declaring any task complete in this directory, verify your changes locally:
`pnpm --filter @project/engine test`
