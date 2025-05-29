
class User {
  constructor(name, age, hobbies = []) {
    this.name = name;
    this.age = age;
    this.hobbies = hobbies;
  }

  greet() {
    return `Hi, I'm ${this.name} and I'm ${this.age} years old.`;
  }

  addHobby(hobby) {
    if (!this.hobbies.includes(hobby)) {
      this.hobbies.push(hobby);
    }
  }

  getHobbies() {
    return this.hobbies;
  }
}

function showUserInfo(user) {
  console.log(user.greet());
  console.log("Hobbies:", user.getHobbies().join(", "));
}

try {
  const user = new User("Monciego", 22, ["coding", "gaming"]);
  user.addHobby("reading");
  showUserInfo(user);

  // Arrow function + map + template literal
  const logs = user.getHobbies().map((hobby, index) => `${index + 1}. ${hobby}`);
  logs.forEach(console.log);

  // Optional chaining and nullish coalescing
  console.log(user?.nickname ?? "No nickname provided");

  // Async/await example
  async function fetchData() {
    return new Promise((resolve) => setTimeout(() => resolve("Fetched Data!"), 1000));
  }

  fetchData().then(console.log);
} catch (error) {
  console.error("Something went wrong:", error);
}
