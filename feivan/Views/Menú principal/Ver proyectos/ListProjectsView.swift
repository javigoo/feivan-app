//
//  ProjectsListView.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import SwiftUI
import CoreData

struct ListProjectsView: View {
    @StateObject var projectVM = ProjectViewModel()

    var body: some View {
        VStack{
            if projectVM.proyectos.count == 0 {
                Text("No hay proyectos")
            } else {
                List {
                    ForEach(projectVM.proyectos, id: \.self) { proyecto in
                        NavigationLink(
                            destination:
                                ProjectsView(
                                    projectVM: ProjectViewModel(project: proyecto)
                                ),
                            label: {
                                ProjectsPreview(
                                    projectVM: ProjectViewModel(project: proyecto)
                                )
                            }
                        )
                    }
                    .onDelete(perform: deleteProject)
                }
            }
        }
        .onAppear(perform: projectVM.getAllProjects)
        .navigationTitle(Text("Ver proyectos"))
    }
    
    private func deleteProject(offsets: IndexSet) {
        withAnimation {
            projectVM.delete(at: offsets, for: projectVM.proyectos)
        }
    }
}
