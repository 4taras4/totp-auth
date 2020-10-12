//
//  AddItemAddItemAssemblyContainer.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import Swinject

final class AddItemAssemblyContainer: Assembly {

	func assemble(container: Container) {
		container.register(AddItemInteractor.self) { (_, presenter: AddItemPresenter) in
			let interactor = AddItemInteractor()
			interactor.output = presenter

			return interactor
		}

		container.register(AddItemRouter.self) { (_, viewController: AddItemViewController) in
			let router = AddItemRouter()
			router.transitionHandler = viewController

			return router
		}

		container.register(AddItemPresenter.self) { (r, viewController: AddItemViewController) in
			let presenter = AddItemPresenter()
			presenter.view = viewController
			presenter.interactor = r.resolve(AddItemInteractor.self, argument: presenter)
			presenter.router = r.resolve(AddItemRouter.self, argument: viewController)

			return presenter
		}

        container.storyboardInitCompleted(AddItemViewController.self) { r, viewController in
            viewController.output = r.resolve(AddItemPresenter.self, argument: viewController)
        }
	}

}
