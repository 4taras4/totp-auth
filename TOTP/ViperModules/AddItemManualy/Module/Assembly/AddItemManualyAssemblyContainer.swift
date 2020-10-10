//
//  AddItemManualyAddItemManualyAssemblyContainer.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import Swinject

final class AddItemManualyAssemblyContainer: Assembly {

	func assemble(container: Container) {
		container.register(AddItemManualyInteractor.self) { (_, presenter: AddItemManualyPresenter) in
			let interactor = AddItemManualyInteractor()
			interactor.output = presenter

			return interactor
		}

		container.register(AddItemManualyRouter.self) { (_, viewController: AddItemManualyViewController) in
			let router = AddItemManualyRouter()
			router.transitionHandler = viewController

			return router
		}

		container.register(AddItemManualyPresenter.self) { (r, viewController: AddItemManualyViewController) in
			let presenter = AddItemManualyPresenter()
			presenter.view = viewController
			presenter.interactor = r.resolve(AddItemManualyInteractor.self, argument: presenter)
			presenter.router = r.resolve(AddItemManualyRouter.self, argument: viewController)

			return presenter
		}

        container.storyboardInitCompleted(AddItemManualyViewController.self) { r, viewController in
            viewController.output = r.resolve(AddItemManualyPresenter.self, argument: viewController)
        }
        
	}

}
