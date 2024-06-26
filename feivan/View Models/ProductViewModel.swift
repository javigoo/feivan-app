//
//  ProductViewModel.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import CoreData
import SwiftUI

class ProductViewModel: ObservableObject {
    private let context = PersistenceController.shared

    @Published var id_producto: UUID = UUID()
    @Published var foto: Data = Data()
    @Published var fotos_detalle: Data = Data()
    @Published var imagen_dibujada: Data = Data()
    @Published var familia: String = ""
    @Published var nombre: String = ""
    @Published var curvas: String = ""
    @Published var material: String = ""
    @Published var color: String = ""
    @Published var tapajuntas: String = ""
    @Published var dimensiones: String = ""
    @Published var apertura: String = ""
    @Published var compacto: String = ""
    @Published var marco_inferior: String = ""
    @Published var huella: String = ""
    @Published var forro_exterior: String = ""
    @Published var cristal: String = ""
    @Published var cerraduras: String = ""
    @Published var manetas: String = ""
    @Published var herraje: String = ""
    @Published var posicion: String = ""
    @Published var instalacion: String = ""
    @Published var persiana: String = ""
    @Published var remates_albanileria: Bool = false
    @Published var medidas_no_buenas: Bool = false
    @Published var unidades: Int16 = 1
    @Published var observaciones: String = ""
    @Published var timestamp: Date = Date()
    
    @Published var composicion: Composicion?
    @Published var proyecto: Proyecto?
    @Published var productos: [Producto] = []
        
    
    func getNumComposition() -> String {
        let product: Producto = getProduct()
        if let productos = composicion?.productos {
            for (n, producto) in productos.enumerated() {
                if product == (producto as! Producto) {
                    return String(n+1)
                }
            }
        }
        return ""
    }
    
    // Constructores

    init() {
    }
    
    init(product: Producto) {
        setProductVM(product: product)
    }
    
    private func setProductVM(product: Producto) {
        id_producto = product.id_producto ?? id_producto
        foto = product.foto ?? foto
        fotos_detalle = product.fotos_detalle ?? fotos_detalle
        imagen_dibujada = product.imagen_dibujada ?? imagen_dibujada
        familia = product.familia ?? familia
        nombre = product.nombre ?? nombre
        curvas = product.curvas ?? curvas
        material = product.material ?? material
        color = product.color ?? color
        tapajuntas = product.tapajuntas ?? tapajuntas
        dimensiones = product.dimensiones ?? dimensiones
        apertura = product.apertura ?? apertura
        compacto = product.compacto ?? compacto
        marco_inferior = product.marco_inferior ?? marco_inferior
        huella = product.huella ?? huella
        forro_exterior = product.forro_exterior ?? forro_exterior
        cristal = product.cristal ?? cristal
        cerraduras = product.cerraduras ?? cerraduras
        manetas = product.manetas ?? manetas
        herraje = product.herraje ?? herraje
        posicion = product.posicion ?? posicion
        instalacion = product.instalacion ?? instalacion
        persiana = product.persiana ?? persiana
        unidades = product.unidades
        remates_albanileria = product.remates_albanileria
        medidas_no_buenas = product.medidas_no_buenas
        observaciones = product.observaciones ?? observaciones
        timestamp = product.timestamp ?? timestamp
        composicion = product.composicion ?? composicion
        proyecto = product.proyecto ?? proyecto
    }
    
    func setProduct(product: Producto) {
        product.id_producto = id_producto
        product.foto = foto
        product.fotos_detalle = fotos_detalle
        product.imagen_dibujada = imagen_dibujada
        product.familia = familia
        product.nombre = nombre
        product.curvas = curvas
        product.material = material
        product.color = color
        product.tapajuntas = tapajuntas
        product.dimensiones = dimensiones
        product.apertura = apertura
        product.compacto = compacto
        product.marco_inferior = marco_inferior
        product.huella = huella
        product.forro_exterior = forro_exterior
        product.cristal = cristal
        product.cerraduras = cerraduras
        product.manetas = manetas
        product.herraje = herraje
        product.posicion = posicion
        product.instalacion = instalacion
        product.persiana = persiana
        product.unidades = unidades
        product.remates_albanileria = remates_albanileria
        product.medidas_no_buenas = medidas_no_buenas
        product.observaciones = observaciones
        product.timestamp = timestamp
        product.composicion = composicion
        product.proyecto = proyecto
    }

    
    // Funciones públicas
    
    func setProductVMAdd2(productVM: ProductViewModel) {
        familia = productVM.familia
        nombre = productVM.nombre
        proyecto = productVM.proyecto
        curvas = productVM.curvas
        material = productVM.material
        color = productVM.color
        tapajuntas = productVM.tapajuntas
        dimensiones = productVM.dimensiones
        apertura = productVM.apertura
        compacto = productVM.compacto
        marco_inferior = productVM.marco_inferior
        huella = productVM.huella
        forro_exterior = productVM.forro_exterior
        cristal = productVM.cristal
        cerraduras = productVM.cerraduras
        manetas = productVM.manetas
        herraje = productVM.herraje
        posicion = productVM.posicion
        instalacion = productVM.instalacion
        persiana = productVM.persiana
        remates_albanileria = productVM.remates_albanileria
        medidas_no_buenas = productVM.medidas_no_buenas
        imagen_dibujada = productVM.imagen_dibujada
    }
    
    func setProductVMAdd3(productVM: ProductViewModel) {
        familia = productVM.familia
        nombre = productVM.nombre
        proyecto = productVM.proyecto
        color = productVM.color
        tapajuntas = productVM.tapajuntas
        cristal = productVM.cristal
        imagen_dibujada = productVM.imagen_dibujada
    }
    
    func addProject(projectVM: ProjectViewModel) {
        self.proyecto = projectVM.getProject()
    }
    
    func save() {
        DispatchQueue.main.async {
            self.setProduct(product: self.getProduct())
            self.context.save()
            self.getAllProducts()
        }
    }
    
    func delete(at offset: IndexSet, for productos: [Producto]) {
        if let first = productos.first, case context.viewContext = first.managedObjectContext {
            offset.map { productos[$0] }.forEach(context.viewContext.delete)
        }
        
        context.save()
        getAllProducts()
    }
    
    func get(attribute: String) -> String {
        switch attribute {
            case "Familia":
                return familia
            case "Nombre":
                return nombre
            case "Curvas":
                return curvas
            case "Material":
                return material
            case "Color":
                return color
            case "Tapajuntas":
                return tapajuntas
            case "Dimensiones":
                return dimensiones
            case "Apertura":
                return apertura
            case "Compacto":
                return compacto
            case "Marco inferior":
                return marco_inferior
            case "Huella":
                return huella
            case "Forro exterior":
                return forro_exterior
            case "Cristal":
                return cristal
            case "Cerraduras":
                return cerraduras
            case "Manetas":
                return manetas
            case "Herraje":
                return herraje
            case "Posición":
                return posicion
            case "Instalación":
                return instalacion
            case "Remates albañilería":
                return remates_albanileria ? "Sí" : "No"
            case "Medidas no buenas":
                return medidas_no_buenas ? "Sí" : "No"
            case "Persiana":
                return persiana
            case "Unidades":
                return String(unidades)
            default:
                print("Error getting \(attribute), \"\(attribute)\" not found")
        }
        return ""
    }
    
    func deleteFoto(at offset: IndexSet) {
        if let index = offset.first {
            if var fotos_detalle = imagesFromCoreData(object: fotos_detalle) {
                fotos_detalle.remove(at: index)
                if let data_fotos_detalle = coreDataObjectFromImages(images: fotos_detalle) {
                    self.fotos_detalle = data_fotos_detalle
                    context.save()
                }
            }
        }
    }
    
    func getAllProducts() {
        let request = Producto.fetchRequest()
        do {
            productos = try context.viewContext.fetch(request)
        } catch {
            print("ERROR in ProductViewModel at getAllProducts()\n")
        }
    }
    
    // Funciones privadas

    func getProduct() -> Producto {
        let request: NSFetchRequest<Producto> = Producto.fetchRequest()
        let query = NSPredicate(format: "%K == %@", "id_producto", id_producto as CVarArg)
        let sort = [NSSortDescriptor(key: "timestamp", ascending: true)]
        
        request.predicate = query
        request.sortDescriptors = sort
        
        do {
            let foundEntities: [Producto] = try context.viewContext.fetch(request)
            if !foundEntities.isEmpty {
                return foundEntities.first!
            }
        } catch {
            let fetchError = error as NSError
            debugPrint(fetchError)
        }

        return Producto(context: context.viewContext)

    }
    
    // Otras
    
    /** Devuelve falso si la familia del producto es igual a alguna de las familias pasadas como parámetro, verdadero de lo contrario **/
    func notShowIf(familias: [String]) -> Bool {
        let familiaSeleccionada = getFamilia()
        if familiaSeleccionada == "Personalizados" {
            return false
        }
        for familia in familias {
            if familiaSeleccionada == familia {
                return false
            }
        }
        return true
    }
    
    /** Devuelve verdadero si la familia del producto es igual a alguna de las familias pasadas como parámetro, falso de lo contrario **/
    func showIf(equalTo: [String]) -> Bool {
        let familiaSeleccionada = getFamilia()
        if familiaSeleccionada == "Personalizados" {
            return true
        }
        for familia in equalTo {
            if familiaSeleccionada == familia {
                return true
            }
        }
        return false
    }
    
    // Getters
    
    func getDimensiones(option: String?) -> String {
        if dimensiones != "" {
            if option == "ancho x alto" {
                return getDimensionesAnchoAlto()
            }
        }
        
        return dimensiones
    }
    
    func getMaterial(option: String?) -> String {
        if material != "" {
            if option == "tipo" {
                return getMaterialTipo()
            }
            if option == "opcion" {
                return getMaterialOpcion()
            }
        }
        
        return dimensiones
    }
    
    func getFamilia() -> String {
        return familia
    }

    // Formatters
    private func getDimensionesAnchoAlto() -> String {
        let currentDimensiones = dimensiones.components(separatedBy: "\n")
        if currentDimensiones.count >= 2 {
            let ancho = currentDimensiones[0].components(separatedBy: " ")[1]
            let alto = currentDimensiones[1].components(separatedBy: " ")[1]
            return ancho+" x "+alto+" mm"
        } else if currentDimensiones.count == 1 {
            return currentDimensiones[0].components(separatedBy: " ")[1]
        }
        
        return dimensiones
    }
    
    private func getMaterialTipo() -> String {
        let currentMaterial = material.components(separatedBy: "\n")
        if currentMaterial.count >= 2 {
            let tipo = currentMaterial[1].components(separatedBy: ":")[1]
            return tipo
        } else if currentMaterial.count == 1 {
            return currentMaterial[0]
        }
        
        return material
    }
    
    private func getMaterialOpcion() -> String {
        let currentMaterial = material.components(separatedBy: "\n")
        return currentMaterial[0]
        
    }
    
    func optionsFor(attribute: String) -> [String] {
        for elemento in hierarchy().elementos {
            if attribute == elemento.nombre {
                return elemento.opciones
            }
        }
        return []
    }
    
    func getRalColors() -> [RalColor] {
        var colores: [RalColor] = []
        for elemento in ral().elementos {
            var color: RalColor = RalColor()
            color.nombre = elemento.names.es
            color.ral = elemento.code
            color.r = Double(elemento.color.rgb.r)
            color.g = Double(elemento.color.rgb.g)
            color.b = Double(elemento.color.rgb.b)
            colores.append(color)
        }
        return colores
    }
    
    func getRalCodes() -> [String] {
        var ral_codes: [String] = []
        for elemento in ral().elementos {
            ral_codes.append(elemento.code)
        }
        return ral_codes
    }
    
    func getRalColor(code: String, color: String) -> Double {
        for elemento in ral().elementos {
            if code == elemento.code{
                if color == "r"{
                    return Double(elemento.color.rgb.r)
                }
                if color == "g"{
                    return Double(elemento.color.rgb.g)
                }
                if color == "b"{
                    return Double(elemento.color.rgb.b)
                }
            }
        }
        return 0.0
    }
    
    func getRalName(code: String) -> String {
        for elemento in ral().elementos {
            if code == elemento.code{
                return elemento.names.es
            }
        }
        return "No name"
    }
    
    func saveDrawing(image: UIImage) {
        imagen_dibujada = uiimage_to_data(uiimage: image)!
        save()
    }
    
    // Devuelve el código con el que empiezan los colores de eso tono
    func getToneCode(tone: String) -> String {
        print(tone)
        // "Amarillos", "Naranjas", "Rojos", "Violetas", "Azules", "Verdes", "Grises", "Marrones", "Blancos y negros"
        switch tone {
            case "Amarillos":
                return "1"
            case "Naranjas":
                return "2"
            case "Rojos":
                return "3"
            case "Violetas":
                return "4"
            case "Azules":
                return "5"
            case "Verdes":
                return "6"
            case "Grises":
                return "7"
            case "Marrones":
                return "8"
            case "Blancos y negros":
                return "9"
            default:
                print("Ral tone not found")
                return "0"
        }
    }
    
    func getRalCode(ral: String) -> String {
        let index = ral.index(ral.startIndex, offsetBy: 0)
        return String(ral[index])
    }
    
    func getSingularFamilia(name: String) -> String {
        if name != "" {
            var nombre = getFamilia()
            if nombre == "Persianas enrollables" {
                return "Persiana enrollable"
            }
            nombre.removeLast()
            return nombre
        }
        return name
    }
    
    func getAttributeValue(attribute_data: String, select_atributte: String) -> String {
        let attribute_data: [String] = attribute_data.components(separatedBy: "\n")
        for data in attribute_data {
            if data.contains(":") {
                let split_data: [String] = data.components(separatedBy: ":")
                let attribute: String = split_data[0]
                let value: String = split_data[1]
                
                if attribute == select_atributte {
                    return value.trimmingCharacters(in: .whitespaces)
                }
                
            }
            if data.contains("\""){
                if select_atributte == "Otro" {
                    return data.replacingOccurrences(of: "\"", with: "")
                }
                return ""
            }
            if data.contains("(") && data.contains(")") {
                if select_atributte == "Anotacion" {
                    let first = data.dropFirst()
                    let second = first.dropLast()
                    return String(second)
                }
                return ""
            }
            if select_atributte == "Valor" {
                return data
            }
            if data.contains(select_atributte) {
                return "true"
            }
        }
        return ""
    }
}

extension ProductViewModel: Identifiable, Hashable {
    var identifier: String {
        return id_producto.uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: ProductViewModel, rhs: ProductViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
