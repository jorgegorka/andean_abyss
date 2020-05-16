# frozen_string_literal: true

STANDARD_DEPLOYMENT = {
  forces: {
    govt: { troops: 30, police: 30, bases: 3, shipments: 0 },
    farc: { guerrillas: 30, bases: 9, shipments: 0 },
    cartel: { guerrillas: 12, bases: 15, shipments: 0 },
    auc: { guerrillas: 18, bases: 6, shipments: 0 }
  },
  resources: { govt: 40, farc: 10, auc: 10, cartel: 10, shipments: 4 },
  aid: 10
}.freeze

DECK_CONTENT = [
  {
    number: 1,
    name: '1st Division',
    capability: CAPABILITY_GOVT,
    order: 'GFAC',
    propaganda: false
  },
  {
    number: 2,
    name: 'Ospina & Mora',
    capability: CAPABILITY_GOVT,
    order: 'GFAC',
    propaganda: false
  },
  {
    number: 3,
    name: 'Tapias',
    capability: CAPABILITY_GOVT,
    order: 'GFAC',
    propaganda: false
  },
  {
    number: 4,
    name: 'Caño Limón - Coveñas',
    capability: CAPABILITY_GOVT,
    order: 'GFCA',
    propaganda: false
  }
].freeze

LOCATIONS_CONTENT = [
  {
    type: CITY,
    number: 1,
    name: 'Bogotá & Villavicencio',
    population: 8,
    neighbours: [14, 20, 21, 13],
    coastal: false
  },
  {
    type: CITY,
    number: 2,
    name: 'Cali',
    population: 3,
    neighbours: [18, 13, 22],
    coastal: false
  },
  {
    type: CITY,
    number: 3,
    name: 'Medellín',
    population: 3,
    neighbours: [18, 12],
    coastal: false
  },
  {
    type: CITY,
    number: 4,
    name: 'Bucaramanga',
    population: 2,
    neighbours: [14, 12],
    coastal: false
  },
  {
    type: CITY,
    number: 5,
    name: 'Igagué & Pereira',
    population: 2,
    neighbours: [18, 12, 13],
    coastal: false
  },
  {
    type: CITY,
    number: 6,
    name: 'Santa Marta & Barranquilla',
    population: 2,
    neighbours: [17, 16],
    coastal: true
  },
  {
    type: CITY,
    number: 7,
    name: 'Cartagena',
    population: 1,
    neighbours: [16],
    coastal: true
  },
  {
    type: CITY,
    number: 8,
    name: 'Cucuta',
    population: 1,
    neighbours: [14],
    coastal: false
  },
  {
    type: CITY,
    number: 9,
    name: 'Neiva',
    population: 1,
    neighbours: [13, 21, 23],
    coastal: false
  },
  {
    type: CITY,
    number: 10,
    name: 'Pasto',
    population: 1,
    neighbours: [22, 13, 23, 47],
    coastal: false
  },
  {
    type: CITY,
    number: 11,
    name: 'Sincelejo & Montería',
    population: 1,
    neighbours: [16, 12, 18],
    coastal: true
  },
  {
    type: PROVINCE,
    number: 12,
    name: 'Antioquia - Bolívar',
    population: 2,
    terrain: MOUNTAIN,
    neighbours: [16, 17, 14, 13, 18, 11, 4, 3, 5],
    coastal: false
  },
  {
    type: PROVINCE,
    number: 13,
    name: 'Huila - Tolima',
    population: 2,
    terrain: MOUNTAIN,
    neighbours: [12, 14, 21, 23, 47, 22, 18, 5, 1, 9, 10, 2, 5],
    coastal: false
  },
  {
    type: PROVINCE,
    number: 14,
    name: 'Santander - Bocayá',
    population: 2,
    terrain: MOUNTAIN,
    neighbours: [17, 15, 20, 21, 13, 12, 16, 8, 1, 4],
    coastal: false
  },
  {
    type: PROVINCE,
    number: 15,
    name: 'Arauca - Casanare',
    population: 1,
    terrain: GRASSLAND,
    neighbours: [14, 27, 20],
    coastal: false
  },
  {
    type: PROVINCE,
    number: 16,
    name: 'Atlántico - Magdalena',
    population: 1,
    terrain: FOREST,
    neighbours: [17, 14, 12, 18, 6, 7, 11],
    coastal: true
  },
  {
    type: PROVINCE,
    number: 17,
    name: 'Cesar - La Guajira',
    population: 1,
    terrain: MOUNTAIN,
    neighbours: [14, 12, 16, 6],
    coastal: true
  },
  {
    type: PROVINCE,
    number: 18,
    name: 'Chocó - Córdoba',
    population: 1,
    terrain: FOREST,
    neighbours: [16, 12, 13, 22, 46, 11, 3, 5, 2],
    coastal: true
  },
  {
    type: PROVINCE,
    number: 19,
    name: 'Guaviare',
    population: 1,
    terrain: FOREST,
    neighbours: [20, 27, 25, 26, 23, 21],
    coastal: false
  },
  {
    type: PROVINCE,
    number: 20,
    name: 'Meta East',
    population: 1,
    terrain: GRASSLAND,
    neighbours: [14, 15, 27, 19, 21, 13, 1],
    coastal: false
  },
  {
    type: PROVINCE,
    number: 21,
    name: 'Meta West',
    population: 2,
    terrain: FOREST,
    neighbours: [14, 20, 19, 23, 13, 1, 9],
    coastal: false
  },
  {
    type: PROVINCE,
    number: 22,
    name: 'Nariño - Cauca',
    population: 1,
    terrain: FOREST,
    neighbours: [18, 13, 23, 47, 2, 10],
    coastal: true
  },
  {
    type: PROVINCE,
    number: 23,
    name: 'Putumayo - Caquetá',
    population: 1,
    terrain: FOREST,
    neighbours: [13, 21, 19, 26, 24, 22, 47, 9, 10],
    coastal: false
  },
  {
    type: PROVINCE,
    number: 24,
    name: 'Amazonas',
    population: 0,
    terrain: FOREST,
    neighbours: [23, 26],
    coastal: false
  },
  {
    type: PROVINCE,
    number: 25,
    name: 'Guainía',
    population: 0,
    terrain: FOREST,
    neighbours: [27, 26, 19],
    coastal: false
  },
  {
    type: PROVINCE,
    number: 26,
    name: 'Vaupés',
    population: 0,
    terrain: FOREST,
    neighbours: [25, 24, 23, 19],
    coastal: false
  },
  {
    type: PROVINCE,
    number: 27,
    name: 'Vichada',
    population: 0,
    terrain: GRASSLAND,
    neighbours: [25, 19, 20, 15],
    coastal: false
  },
  {
    type: LOC,
    number: 28,
    name: 'Arauca - Cúcuta',
    economy: 3,
    route: [8],
    neighbours: []
  },
  {
    type: LOC,
    number: 29,
    name: 'Cúcuta - Ayacucho',
    economy: 3,
    route: [8],
    neighbours: []
  },
  {
    type: LOC,
    number: 30,
    name: 'Ayacucho - Sincelejo',
    economy: 3,
    route: [11],
    neighbours: []
  },
  {
    type: LOC,
    number: 31,
    name: 'Bucaramanga - Ayacucho',
    economy: 2,
    route: [4],
    neighbours: []
  },
  {
    type: LOC,
    number: 32,
    name: 'Ayacucho - Barranquilla',
    economy: 2,
    route: [6],
    neighbours: []
  },
  {
    type: LOC,
    number: 33,
    name: 'Medellín - Sincelejo',
    economy: 2,
    route: [11, 3],
    neighbours: []
  },
  {
    type: LOC,
    number: 34,
    name: 'Neiva - Bogotá',
    economy: 2,
    route: [1, 9],
    neighbours: []
  },
  {
    type: LOC,
    number: 35,
    name: 'Yopal - Bogotá',
    economy: 2,
    route: [1],
    neighbours: []
  },
  {
    type: LOC,
    number: 36,
    name: 'Bogotá - Ibagué - Bucaramanga',
    economy: 2,
    route: [1, 4, 5],
    neighbours: []
  },
  {
    type: LOC,
    number: 37,
    name: 'Cartajena - Sincelejo',
    economy: 1,
    route: [7, 11],
    neighbours: []
  },
  {
    type: LOC,
    number: 38,
    name: 'Medellín - Ibagué',
    economy: 1,
    route: [3, 5],
    neighbours: []
  },
  {
    type: LOC,
    number: 39,
    name: 'Ibagué - Cali',
    economy: 1,
    route: [5, 2],
    neighbours: []
  },
  {
    type: LOC,
    number: 40,
    name: 'Cali - Buenaventura',
    economy: 1,
    route: [2],
    neighbours: []
  },
  {
    type: LOC,
    number: 41,
    name: 'Cartagena - Barranquilla',
    economy: 1,
    route: [6, 7],
    neighbours: []
  },
  {
    type: LOC,
    number: 42,
    name: 'Bogotá - San José',
    economy: 1,
    route: [1],
    neighbours: []
  },
  {
    type: LOC,
    number: 43,
    name: 'Cali - Pasto',
    economy: 1,
    route: [2, 10],
    neighbours: []
  },
  {
    type: LOC,
    number: 44,
    name: 'Neiva - Pasto',
    economy: 1,
    route: [9, 10],
    neighbours: []
  },
  {
    type: LOC,
    number: 45,
    name: 'Pasto - Tumaco',
    economy: 1,
    route: [10],
    neighbours: []
  }
].freeze

ADITIONAL_PROVINCES = [
  {
    type: PROVINCE,
    number: 46,
    name: 'Panamá',
    population: 0,
    terrain: GRASSLAND,
    neighbours: [],
    country: PANAMA
  },
  {
    type: PROVINCE,
    number: 47,
    name: 'Ecuador',
    population: 0,
    terrain: GRASSLAND,
    neighbours: [],
    country: VENEZUELA
  }
].freeze
