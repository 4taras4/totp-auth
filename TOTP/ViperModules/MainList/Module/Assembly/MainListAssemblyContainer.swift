//
//  MainListMainListAssemblyContainer.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import Swinject
import SwinjectStoryboard

final class MainListAssemblyContainer: Assembly {

	func assemble(container: Container) {
		container.register(MainListInteractor.self) { (_, presenter: MainListPresenter) in
			let interactor = MainListInteractor()
			interactor.output = presenter

			return interactor
		}

		container.register(MainListRouter.self) { (_, viewController: MainListViewController) in
			let router = MainListRouter()
			router.transitionHandler = viewController

			return router
		}

		container.register(MainListPresenter.self) { (r, viewController: MainListViewController) in
			let presenter = MainListPresenter()
			presenter.view = viewController
			presenter.interactor = r.resolve(MainListInteractor.self, argument: presenter)
			presenter.router = r.resolve(MainListRouter.self, argument: viewController)

			return presenter
		}

        container.storyboardInitCompleted(MainListViewController.self) { r, viewController in
            viewController.output = r.resolve(MainListPresenter.self, argument: viewController)
        }
	}

}
