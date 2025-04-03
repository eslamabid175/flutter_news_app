// SOLID Principle: Interface Segregation Principle (ISP)
// This interface defines only the methods needed for article operations
// Clean Architecture: Defines repository contract in domain layer

import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

// Abstract class defining the contract for article operations
// SOLID Principle: Dependency Inversion Principle (DIP)
// High-level modules depend on abstractions, not concrete implementations
abstract class ArticleRepository {
  // Returns Either type for error handling
  // Left side contains Failure, Right side contains success data
  // Method to fetch top headlines
  Future<Either<Failure, List<ArticleModel>>> getTopHeadlines();

  // Method to search articles by query
  Future<Either<Failure, List<ArticleModel>>> searchArticles(String query);
}


// Clean Architecture Flow in this Implementation:
//
// Domain Layer:
//
// Defines business rules through use cases
// Contains repository interfaces
// Independent of external frameworks
// Data Layer:
//
// Implements repository interfaces
// Handles data sources (remote and local)
// Contains models that extend domain entities
// Presentation Layer:
//
// Uses BLoC pattern for state management
// Depends on use cases from domain layer
// Provides UI components and state management
// SOLID Principles Applied:
//
// Single Responsibility: Each class has one specific purpose
// Open/Closed: Classes are open for extension but closed for modification
// Liskov Substitution: Subtypes can replace their base types
// Interface Segregation: Interfaces are specific to client needs
// Dependency Inversion: High-level modules depend on abstractions