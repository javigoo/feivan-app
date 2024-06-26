//
//  Data.swift
//  Feivan
//
//  Created by javigo on 16/12/21.
//

import SwiftUI

//let available_size = CGSize(width: page.width, height: page.height)
//let used_space = attributes_text.boundingRect(with: available_size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
let black: UIImage = UIImage(named: "black")!
let green: UIImage = UIImage(named: "green")!
let purple: UIImage = UIImage(named: "purple")!

func addBottomProduct(shared: PDFData, page: CGRect, context: CGContext, product: Producto) {
    let product = ProductViewModel(product: product)
    
    let page_image = CGRect(
        x: page.origin.x,
        y: page.origin.y + (page.height / 2) + shared.half_padding,
        width: (page.width / 3) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )

    let page_foto = CGRect(
        x: page_image.origin.x + page_image.width + shared.half_padding,
        y: page.origin.y + (page.height / 2) + shared.half_padding,
        width: (page.width / 3) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )
    
    let page_data = CGRect(
        x: page_foto.origin.x + page_foto.width + shared.half_padding,
        y: page.origin.y + (page.height / 2) + shared.half_padding,
        width: (page.width / 3),
        height: (page.height / 2) - shared.half_padding
    )
    
//    black.draw(in: page_image)
//    green.draw(in: page_foto)
//    purple.draw(in: page_data)
    
    addProductImage(shared: shared, page: page_image, product: product)
    addProductPhoto(shared: shared, page: page_foto, product: product)
    addProductData(shared: shared, page: page_data, context: context, product: product)
    
}

func addTopProduct(shared: PDFData, page: CGRect, context: CGContext, product: Producto) {
    let product = ProductViewModel(product: product)
    
    let page_image = CGRect(
        x: page.origin.x,
        y: page.origin.y,
        width: (page.width / 3) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )

    let page_foto = CGRect(
        x: page_image.origin.x + page_image.width + shared.half_padding,
        y: page.origin.y,
        width: (page.width / 3) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )
    
    let page_data = CGRect(
        x: page_foto.origin.x + page_foto.width + shared.half_padding,
        y: page.origin.y,
        width: (page.width / 3),
        height: (page.height / 2) - shared.half_padding
    )
    
//    black.draw(in: page_image)
//    green.draw(in: page_foto)
//    purple.draw(in: page_data)
    
    addProductImage(shared: shared, page: page_image, product: product)
    addProductPhoto(shared: shared, page: page_foto, product: product)
    addProductData(shared: shared, page: page_data, context: context, product: product)
    
}

func addProductAllPage(shared: PDFData, page: CGRect, context: CGContext, product: Producto) {
    let product = ProductViewModel(product: product)
    
    let page_image = CGRect(
        x: page.origin.x,
        y: page.origin.y,
        width: (page.width / 2) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )

    let page_foto = CGRect(
        x: page.origin.x,
        y: page.origin.y + (page.height / 2) + shared.half_padding,
        width: (page.width / 2) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )
    
    let page_data = CGRect(
        x: page.origin.x + (page.width / 2) + shared.half_padding,
        y: page.origin.y,
        width: (page.width / 2) - shared.half_padding,
        height: page.height
    )
    
//    black.draw(in: page_image)
//    green.draw(in: page_foto)
//    purple.draw(in: page_data)
    
    addProductImage(shared: shared, page: page_image, product: product)
    addProductPhoto(shared: shared, page: page_foto, product: product)
    addProductData(shared: shared, page: page_data, context: context, product: product)

}

func addProductImage(shared: PDFData, page: CGRect, product: ProductViewModel) {
    
    if product.nombre.isEmpty {
        return
    }
    
    let image: UIImage
    if product.imagen_dibujada.isEmpty {
        image = UIImage(imageLiteralResourceName: product.nombre)
    } else {
        image = UIImage(data: product.imagen_dibujada)!
    }
   
    let aspectWidth = page.width / image.size.width
    let aspectHeight = page.height / image.size.height
    let aspectRatio = min(aspectWidth, aspectHeight)

    let scaledWidth = image.size.width * aspectRatio
    let scaledHeight = image.size.height * aspectRatio
    
    var origin_x: Double = page.origin.x
    if page.width > scaledWidth  {
        origin_x += (page.width - scaledWidth) / 2
    }
    
    var origin_y: Double = page.origin.y
    if page.height > scaledHeight  {
        origin_y += (page.height - scaledHeight) / 2
    }
    
    let scaled_page = CGRect(x: page.origin.x,
                             y: origin_y,
                             width: scaledWidth,
                             height: scaledHeight
                        )
    
    image.draw(in: scaled_page)
    
}

func addProductPhoto(shared: PDFData, page: CGRect, product: ProductViewModel) {
    if product.foto.isEmpty {
        return
    }

    let image = UIImage(data: product.foto)!

    let aspectWidth = page.width / image.size.width
    let aspectHeight = page.height / image.size.height
    let aspectRatio = min(aspectWidth, aspectHeight)

    let scaledWidth = image.size.width * aspectRatio
    let scaledHeight = image.size.height * aspectRatio
    
    var origin_x: Double = page.origin.x
    if page.width > scaledWidth  {
        origin_x += (page.width - scaledWidth) / 2
    }
    
    var origin_y: Double = page.origin.y
    if page.height > scaledHeight  {
        origin_y += (page.height - scaledHeight) / 2
    }
    
    let scaled_page = CGRect(x: page.origin.x,
                             y: origin_y,
                             width: scaledWidth,
                             height: scaledHeight
                        )

    image.draw(in: scaled_page)
    
}

func addProductData(shared: PDFData, page: CGRect, context: CGContext, product: ProductViewModel) {
    
    let atributos = ["Unidades", "Curvas", "Material", "Color", "Tapajuntas", "Dimensiones", "Cristal", "Apertura", "Compacto", "Marco inferior", "Forro exterior", "Cerraduras", "Manetas", "Herraje", "Posición", "Instalación", "Persiana", "Huella", "Remates albañilería", "Medidas no buenas"]
    
    var resultado_atributos: String = ""
    var resultado_valores: String = ""
    var extras_producto: String = ""

    for atributo_to_print in atributos {
        let valores_atributo = product.get(attribute: atributo_to_print)
        
        if atributo_to_print == "Unidades" && valores_atributo == "1" {
            continue
        }
        
        if atributo_to_print == "Medidas no buenas" && valores_atributo == "No" {
            continue
        }
        
        if atributo_to_print == "Remates albañilería" && valores_atributo == "No" {
            continue
        }
            
        let valores_atributos = product.get(attribute: atributo_to_print)
        let lineas = valores_atributos.split(separator: "\n")
        let lineas_atributo = lineas.count
        
        if lineas_atributo != 0 {
            
            var total_lineas = lineas_atributo
            let size_count = 35
            for value in lineas {
                if value.count > size_count {
                    var value_copy = value
                    while value_copy.count > size_count {
                        let index = value_copy.index(value_copy.startIndex, offsetBy: size_count)
                        let substring_to_print = value_copy.prefix(upTo: index)
                        value_copy = value_copy.suffix(from: index)
                        resultado_valores += "\(substring_to_print)\n"
                        total_lineas += 1
                    }
                    resultado_valores += "\(value_copy)\n"
                    total_lineas += 1
                } else {
                    resultado_valores += "\(value)\n"
                }
            }
            resultado_valores += "\n"
            
            resultado_atributos += "\(atributo_to_print)" + String(repeating: "\n", count: total_lineas + 1)

        }
    }
    
    let extra_space = CGFloat(10)
    
    var observaciones_space = CGFloat(35)
    if product.observaciones.isEmpty {
        observaciones_space = CGFloat(0)
    }
    
    let attributes_page = CGRect(x: page.origin.x,
                             y: page.origin.y,
                             width: page.width * 0.4,
                             height: page.height - extra_space - observaciones_space
                        )
    let values_page = CGRect(x: page.origin.x + attributes_page.width,
                             y: page.origin.y,
                             width: page.width - attributes_page.width,
                             height: page.height - extra_space - observaciones_space
                        )
    
    let observaciones_page = CGRect(x: page.origin.x,
                                    y: page.origin.y + page.height - observaciones_space - extra_space - 5,
                             width: page.width,
                             height: observaciones_space - 5
                        )
    
    let all_page = CGRect(x: page.origin.x,
                             y: page.origin.y + page.height - extra_space,
                             width: page.width,
                             height: extra_space
                        )
    
    
    let attributes_font_size = getTextFont(string: resultado_atributos, font: shared.font_size, weight: .bold, width: attributes_page.width, height: attributes_page.height)
    let values_font_size = getTextFont(string: resultado_valores, font: shared.font_size, weight: .regular, width: values_page.width, height: values_page.height)
    let fontSize = min(attributes_font_size, values_font_size)
    
    //let attributes_max_lenght = get_max_lenght(text: resultado_atributos)
    
    var textFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    let text_attributes = [
        NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
        NSAttributedString.Key.font: textFont
        ]
    
    textFont = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .right
    paragraphStyle.lineBreakMode = .byWordWrapping
    let text_values = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont
    ]
    
    if !product.fotos_detalle.isEmpty {
        extras_producto.append("Este producto contiene fotos detalle adjuntas al final del documento")
    }
    
    textFont = UIFont.systemFont(ofSize: getTextFont(string: extras_producto, font: shared.font_size, weight: .bold, width: all_page.width, height: all_page.height), weight: .bold)
    let extras_style = NSMutableParagraphStyle()
    extras_style.lineBreakMode = .byWordWrapping
    let extras_text = [
        NSAttributedString.Key.paragraphStyle: extras_style,
        NSAttributedString.Key.font: textFont
    ]
    
    if !product.observaciones.isEmpty {
        textFont = UIFont.systemFont(ofSize: getTextFont(string: "Este producto contiene fotos detalle adjuntas al final del documento", font: shared.font_size, weight: .bold, width: all_page.width, height: all_page.height), weight: .regular)
    }
    
    let observaciones_style = NSMutableParagraphStyle()
    observaciones_style.lineBreakMode = .byWordWrapping
    let text_observaciones = [
        NSAttributedString.Key.paragraphStyle: observaciones_style,
        NSAttributedString.Key.font: textFont
    ]
    
    
    let attributes_text = NSAttributedString(string: resultado_atributos, attributes: text_attributes)
    //purple.draw(in: attributes_page)
    attributes_text.draw(in: attributes_page)
        
    let values_text = NSAttributedString(string: resultado_valores, attributes: text_values)
    //green.draw(in: values_page)
    values_text.draw(in: values_page)
        
    if !product.observaciones.isEmpty {
        let observaciones_text = NSAttributedString(string: product.observaciones, attributes: text_observaciones)
        //black.draw(in: all_page)
        observaciones_text.draw(in: observaciones_page)
    }
    
    let anotaciones_text = NSAttributedString(string: extras_producto, attributes: extras_text)
    //black.draw(in: all_page)
    anotaciones_text.draw(in: all_page)

}

func get_max_lenght(text: String) -> Int {
    let lines = text.split(separator: "\n")
    var max_lenght = 0
    for line in lines {
        if line.count > max_lenght {
            print("new max lenght line: ", line, line.count)
            max_lenght = line.count
        }
    }
    return max_lenght
}

func addProductTopPage(shared: PDFData, product: Producto) {
    let product = ProductViewModel(product: product)
    print("\(product.familia) se dibuja arriba en la página" )
}

func addProductBottomPage(shared: PDFData, product: Producto) {
    let product = ProductViewModel(product: product)
    print("\(product.familia) se dibuja abajo en la página" )
}
