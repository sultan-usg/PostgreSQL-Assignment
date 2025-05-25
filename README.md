
## How does TypeScript help in improving code quality and project maintainability?

TypeScript improves the code quality and maintainability by adding type checking, which helps to catch errors from beginning during development. It will make your code easier to understand, auto-complete, and refactor, and it prevents common bugs by ensuring variables, functions, and objects are used correctly. This leads to more reliable, organized, and scalable projects.

TypeScript helps make your code better and easier to manage by:

### 1. Catch mistakes early
TypeScript checks your code while you're writing it, so you catch errors before running it.  
**Example:**
```ts
let age: number = "25";  // Error: Type 'string' is not assignable to type 'number'
```

### 2. Making code easier to understand
You can see what each function or variable is supposed to do because types describe them.  
**Example:**
```ts
function greet(name: string): string {
  return "Hello, " + name;
}
// Now you know 'name' must be a string and the function returns a string.
```

### 3. Helping with auto-complete and suggestions
Most code editors can give better hints when you use TypeScript.  
**Example:**
```ts
let user = { name: "Ali", age: 30 };
// user. (your editor will suggest name and age)
```

### 4. Preventing bugs when changing code
When you update one part, TypeScript tells you what else needs to change so nothing breaks.  
**Example:**
If you rename a field in an object, TypeScript will show errors in all places that use it.

### 5. Working well in big projects
In large apps with many files, TypeScript keeps things organized and consistent.

> **In short:** TypeScript is like a helpful assistant that checks your code, explains it better, and protects it from bugs — especially useful as your project grows.





## Explain the difference between any, unknown, and never types in TypeScript

The `any`, `unknown`, and `never` types in TypeScript serve different purposes when dealing with values of uncertain or impossible types.

Here’s a simple and easy explanation of the difference between `any`, `unknown`, and `never` in TypeScript — with short descriptions and examples:

---

### 1. `any` – anything goes
- **Description:** You can assign any value, and TypeScript won't check it.
- **Use it when:** You don’t care about the type or want to skip checking.

**Example:**
```ts
let value: any = "Hello";
value = 42;       // Okay
value = true;     // Okay
value.toUpperCase(); // No error, but might break if value is not a string
// Danger: It disables type safety.
```

---

### 2. `unknown` – safe version of `any`
- **Description:** Like `any`, but TypeScript won’t let you use the value unless you check its type first.
- **Use it when:** You don’t know the type yet, but want to be safe.

**Example:**
```ts
let value: unknown = "Hello";
value = 42; // Okay
// value.toUpperCase(); // Error: must check type first

if (typeof value === "string") {
  console.log(value.toUpperCase()); // Now it's safe
}
// Safer than any, forces you to check before using.
```

---

### 3. `never` – this should never happen
- **Description:** A value that should never exist (e.g., a function that always throws or never returns).
- **Use it when:** You want to mark unreachable code or impossible cases.

**Example 1:**
```ts
function throwError(): never {
  throw new Error("Something went wrong!");
}
```

**Example 2:**
```ts
function check(value: string | number) {
  if (typeof value === "string") {
    console.log("string");
  } else if (typeof value === "number") {
    console.log("number");
  } else {
    // TypeScript knows: value is never anything else
    const neverValue: never = value; // type-safe check
  }
}
```
