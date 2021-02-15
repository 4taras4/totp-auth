//
//  AddFolderItemsAddFolderItemsAssemblyContainer.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import Swinject

final class AddFolderItemsAssemblyContainer: Assembly {

	func assemble(container: Container) {
		container.register(AddFolderItemsInteractor.self) { (_, presenter: AddFolderItemsPresenter) in
			let interactor = AddFolderItemsInteractor()
			interactor.output = presenter

			return interactor
		}

		container.register(AddFolderItemsRouter.self) { (_, viewController: AddFolderItemsViewController) in
			let router = AddFolderItemsRouter()
			router.transitionHandler = viewController

			return router
		}

        container.register(AddFolderItemsPresenter.self) { (r, viewController: AddFolderItemsViewController, folder: Folder) in
			let presenter = AddFolderItemsPresenter()
			presenter.view = viewController
			presenter.interactor = r.resolve(AddFolderItemsInteractor.self, argument: presenter)
			presenter.router = r.resolve(AddFolderItemsRouter.self, argument: viewController)
            presenter.addItemsFor(folder: folder)
			return presenter
		}

        container.storyboardInitCompleted(AddFolderItemsViewController.self) { r, viewController in
            viewController.output = r.resolve(AddFolderItemsPresenter.self, argument: viewController)
        }
	}

}
