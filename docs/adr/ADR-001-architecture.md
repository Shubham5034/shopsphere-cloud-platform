# ADR-001

## Title

Adopt Microservices Architecture for ShopSphere Cloud Platform

## Status

Accepted

## Context

The objective of this project is to simulate a production-grade cloud-native platform while focusing on DevOps engineering practices.

## Decision

Adopt a microservices architecture consisting of:

- User Service
- Product Service
- Cart Service
- Order Service
- Inventory Service
- Notification Service
- Analytics Service

Platform services include:

- Kong
- PostgreSQL
- RabbitMQ
- Kafka
- Redis

## Consequences

### Pros

- Independent deployments
- Better scalability
- Fault isolation
- Event-driven communication
- Production-like architecture

### Cons

- Increased operational complexity
- More Kubernetes resources
- More CI/CD pipelines