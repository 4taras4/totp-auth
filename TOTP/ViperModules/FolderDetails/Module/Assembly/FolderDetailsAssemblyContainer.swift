//
//  FolderDetailsFolderDetailsAssemblyContainer.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import Swinject

final class FolderDetailsAssemblyContainer: Assembly {

	func assemble(container: Container) {
		container.register(FolderDetailsInteractor.self) { (_, presenter: FolderDetailsPresenter) in
			let interactor = FolderDetailsInteractor()
			interactor.output = presenter

			return interactor
		}

		container.register(FolderDetailsRouter.self) { (_, viewController: FolderDetailsViewController) in
			let router = FolderDetailsRouter()
			router.transitionHandler = viewController

			return router
		}

        container.register(FolderDetailsPresenter.self) { (r, viewController: FolderDetailsViewController, folder: Folder) in
			let presenter = FolderDetailsPresenter()
			presenter.view = viewController
			presenter.interactor = r.resolve(FolderDetailsInteractor.self, argument: presenter)
			presenter.router = r.resolve(FolderDetailsRouter.self, argument: viewController)
            presenter.setFolder(item: folder)
			return presenter
		}
        
        container.storyboardInitCompleted(FolderDetailsViewController.self) { r, viewController in
            viewController.output = r.resolve(FolderDetailsPresenter.self, argument: viewController)
        }

	}

}
