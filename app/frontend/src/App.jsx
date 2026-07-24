function App() {
  const services = [
    "User Service",
    "Product Service",
    "Cart Service",
    "Order Service",
    "Inventory Service",
    "Notification Service",
    "Analytics Service",
  ];

  return (
    <div style={{ fontFamily: "Arial", padding: "40px" }}>
      <h1>🛒 ShopSphere Cloud Platform</h1>

      <h2>Microservices Dashboard</h2>

      <hr />

      <h3>Services</h3>

      <ul>
        {services.map((service) => (
          <li key={service}>🟢 {service}</li>
        ))}
      </ul>

      <hr />

      <p><strong>Frontend:</strong> Running</p>
      <p><strong>Backend:</strong> Under Development</p>
      <p><strong>API Gateway:</strong> Kong</p>
      <p><strong>Platform:</strong> Kubernetes</p>
    </div>
  );
}

export default App;
