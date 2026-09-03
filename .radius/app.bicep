extension radius

param environment string

@description('Username for the OCI registry used by the container image recipe.')
@secure()
param registryUsername string

@description('Password or token for the OCI registry used by the container image recipe.')
@secure()
param registryPassword string

resource microservicesDemoApp 'Radius.Core/applications@2025-08-01-preview' = {
  name: 'microservices-demo'
  properties: {
    environment: environment
  }
}

resource redisCache 'Radius.Data/redisCaches@2025-08-01-preview' = {
  name: 'redis'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/cartservice/src/Startup.cs#L29'
    size: 'S'
  }
}

resource registryCreds 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'radius-ghcr-registry-creds'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: '.radius/app.bicep'
    data: {
      password: {
        value: registryPassword
      }
      username: {
        value: registryUsername
      }
    }
  }
}

resource adserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'adservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/adservice/Dockerfile#L1'
    build: {
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
      source: 'git::https://github.com/willdavsmith/microservices-demo.git//src/adservice?ref=5e920ae00cda5e8afbf463645f5f3354d0ba6ef7'
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource cartserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'cartservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/cartservice/src/Dockerfile#L1'
    build: {
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
      source: 'git::https://github.com/willdavsmith/microservices-demo.git//src/cartservice/src?ref=5e920ae00cda5e8afbf463645f5f3354d0ba6ef7'
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource checkoutserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'checkoutservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/checkoutservice/Dockerfile#L1'
    build: {
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
      source: 'git::https://github.com/willdavsmith/microservices-demo.git//src/checkoutservice?ref=5e920ae00cda5e8afbf463645f5f3354d0ba6ef7'
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource currencyserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'currencyservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/currencyservice/Dockerfile#L1'
    build: {
      platforms: [
        'linux/amd64'
      ]
      source: 'git::https://github.com/willdavsmith/microservices-demo.git//src/currencyservice?ref=5e920ae00cda5e8afbf463645f5f3354d0ba6ef7'
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource emailserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'emailservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/emailservice/Dockerfile#L1'
    build: {
      platforms: [
        'linux/amd64'
      ]
      source: 'git::https://github.com/willdavsmith/microservices-demo.git//src/emailservice?ref=5e920ae00cda5e8afbf463645f5f3354d0ba6ef7'
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource frontendImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'frontend-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/frontend/Dockerfile#L1'
    build: {
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
      source: 'git::https://github.com/willdavsmith/microservices-demo.git//src/frontend?ref=5e920ae00cda5e8afbf463645f5f3354d0ba6ef7'
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource paymentserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'paymentservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/paymentservice/Dockerfile#L1'
    build: {
      platforms: [
        'linux/amd64'
      ]
      source: 'git::https://github.com/willdavsmith/microservices-demo.git//src/paymentservice?ref=5e920ae00cda5e8afbf463645f5f3354d0ba6ef7'
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource productcatalogserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'productcatalogservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/productcatalogservice/Dockerfile#L1'
    build: {
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
      source: 'git::https://github.com/willdavsmith/microservices-demo.git//src/productcatalogservice?ref=5e920ae00cda5e8afbf463645f5f3354d0ba6ef7'
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource recommendationserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'recommendationservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/recommendationservice/Dockerfile#L1'
    build: {
      platforms: [
        'linux/amd64'
      ]
      source: 'git::https://github.com/willdavsmith/microservices-demo.git//src/recommendationservice?ref=5e920ae00cda5e8afbf463645f5f3354d0ba6ef7'
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource shippingserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'shippingservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/shippingservice/Dockerfile#L1'
    build: {
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
      source: 'git::https://github.com/willdavsmith/microservices-demo.git//src/shippingservice?ref=5e920ae00cda5e8afbf463645f5f3354d0ba6ef7'
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource adserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'adservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/adservice/src/main/java/hipstershop/AdService.java#L53'
    containers: {
      adservice: {
        image: adserviceImage.properties.imageReference
        env: {
          PORT: {
            value: '9555'
          }
        }
        ports: {
          grpc: {
            containerPort: 9555
          }
        }
        resources: {
          limits: {
            cpu: '300m'
            memoryInMib: 300
          }
          requests: {
            cpu: '200m'
            memoryInMib: 180
          }
        }
      }
    }
  }
}

resource cartserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'cartservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/cartservice/src/Program.cs#L19'
    containers: {
      cartservice: {
        image: cartserviceImage.properties.imageReference
        env: {
          REDIS_ADDR: {
            valueFrom: {
              secretKeyRef: {
                secretName: redisCache.properties.secrets.name
                key: 'url'
              }
            }
          }
        }
        ports: {
          grpc: {
            containerPort: 7070
          }
        }
        resources: {
          limits: {
            cpu: '300m'
            memoryInMib: 128
          }
          requests: {
            cpu: '200m'
            memoryInMib: 64
          }
        }
      }
    }
  }
}

resource checkoutserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'checkoutservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/checkoutservice/main.go#L88'
    containers: {
      checkoutservice: {
        image: checkoutserviceImage.properties.imageReference
        env: {
          CART_SERVICE_ADDR: {
            value: '${cartserviceContainer.properties.hosts['cartservice']}:7070'
          }
          CURRENCY_SERVICE_ADDR: {
            value: '${currencyserviceContainer.properties.hosts['currencyservice']}:7000'
          }
          EMAIL_SERVICE_ADDR: {
            value: '${emailserviceContainer.properties.hosts['emailservice']}:8080'
          }
          PAYMENT_SERVICE_ADDR: {
            value: '${paymentserviceContainer.properties.hosts['paymentservice']}:50051'
          }
          PORT: {
            value: '5050'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: '${productcatalogserviceContainer.properties.hosts['productcatalogservice']}:3550'
          }
          SHIPPING_SERVICE_ADDR: {
            value: '${shippingserviceContainer.properties.hosts['shippingservice']}:50051'
          }
        }
        ports: {
          grpc: {
            containerPort: 5050
          }
        }
        resources: {
          limits: {
            cpu: '200m'
            memoryInMib: 128
          }
          requests: {
            cpu: '100m'
            memoryInMib: 64
          }
        }
      }
    }
  }
}

resource currencyserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'currencyservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/currencyservice/server.js#L182'
    containers: {
      currencyservice: {
        image: currencyserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '7000'
          }
        }
        ports: {
          grpc: {
            containerPort: 7000
          }
        }
        resources: {
          limits: {
            cpu: '200m'
            memoryInMib: 128
          }
          requests: {
            cpu: '100m'
            memoryInMib: 64
          }
        }
      }
    }
  }
}

resource emailserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'emailservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/emailservice/email_server.py#L118'
    containers: {
      emailservice: {
        image: emailserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '8080'
          }
        }
        ports: {
          grpc: {
            containerPort: 8080
          }
        }
        resources: {
          limits: {
            cpu: '200m'
            memoryInMib: 128
          }
          requests: {
            cpu: '100m'
            memoryInMib: 64
          }
        }
      }
    }
  }
}

resource frontendContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'frontend'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/frontend/main.go#L91'
    containers: {
      frontend: {
        image: frontendImage.properties.imageReference
        env: {
          AD_SERVICE_ADDR: {
            value: '${adserviceContainer.properties.hosts['adservice']}:9555'
          }
          CART_SERVICE_ADDR: {
            value: '${cartserviceContainer.properties.hosts['cartservice']}:7070'
          }
          CHECKOUT_SERVICE_ADDR: {
            value: '${checkoutserviceContainer.properties.hosts['checkoutservice']}:5050'
          }
          CURRENCY_SERVICE_ADDR: {
            value: '${currencyserviceContainer.properties.hosts['currencyservice']}:7000'
          }
          ENABLE_PROFILER: {
            value: '0'
          }
          PORT: {
            value: '8080'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: '${productcatalogserviceContainer.properties.hosts['productcatalogservice']}:3550'
          }
          RECOMMENDATION_SERVICE_ADDR: {
            value: '${recommendationserviceContainer.properties.hosts['recommendationservice']}:8080'
          }
          SHIPPING_SERVICE_ADDR: {
            value: '${shippingserviceContainer.properties.hosts['shippingservice']}:50051'
          }
          SHOPPING_ASSISTANT_SERVICE_ADDR: {
            value: 'shoppingassistantservice:80'
          }
        }
        ports: {
          web: {
            containerPort: 8080
          }
        }
        resources: {
          limits: {
            cpu: '200m'
            memoryInMib: 128
          }
          requests: {
            cpu: '100m'
            memoryInMib: 64
          }
        }
      }
    }
  }
}

resource paymentserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'paymentservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/paymentservice/index.js#L73'
    containers: {
      paymentservice: {
        image: paymentserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '50051'
          }
        }
        ports: {
          grpc: {
            containerPort: 50051
          }
        }
        resources: {
          limits: {
            cpu: '200m'
            memoryInMib: 128
          }
          requests: {
            cpu: '100m'
            memoryInMib: 64
          }
        }
      }
    }
  }
}

resource productcatalogserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'productcatalogservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/productcatalogservice/server.go#L68'
    containers: {
      productcatalogservice: {
        image: productcatalogserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '3550'
          }
        }
        ports: {
          grpc: {
            containerPort: 3550
          }
        }
        resources: {
          limits: {
            cpu: '200m'
            memoryInMib: 128
          }
          requests: {
            cpu: '100m'
            memoryInMib: 64
          }
        }
      }
    }
  }
}

resource recommendationserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'recommendationservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/recommendationservice/recommendation_server.py#L97'
    containers: {
      recommendationservice: {
        image: recommendationserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '8080'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: '${productcatalogserviceContainer.properties.hosts['productcatalogservice']}:3550'
          }
        }
        ports: {
          grpc: {
            containerPort: 8080
          }
        }
        resources: {
          limits: {
            cpu: '200m'
            memoryInMib: 450
          }
          requests: {
            cpu: '100m'
            memoryInMib: 220
          }
        }
      }
    }
  }
}

resource shippingserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'shippingservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/shippingservice/main.go#L56'
    containers: {
      shippingservice: {
        image: shippingserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '50051'
          }
        }
        ports: {
          grpc: {
            containerPort: 50051
          }
        }
        resources: {
          limits: {
            cpu: '200m'
            memoryInMib: 128
          }
          requests: {
            cpu: '100m'
            memoryInMib: 64
          }
        }
      }
    }
  }
}

resource frontendRoute 'Radius.Compute/routes@2025-08-01-preview' = {
  name: 'frontend-route'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'kubernetes-manifests/frontend.yaml#L124'
    kind: 'HTTP'
    rules: [
      {
        matches: [
          {
            httpPath: '/'
          }
        ]
        destinationContainer: {
          resourceId: frontendContainer.id
          containerName: 'frontend'
          containerPort: 8080
        }
      }
    ]
  }
}
