//
//  SettingsSettingsAssemblyContainer.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import Swinject

final class SettingsAssemblyContainer: Assembly {

	func assemble(container: Container) {
		container.register(SettingsInteractor.self) { (_, presenter: SettingsPresenter) in
			let interactor = SettingsInteractor()
			interactor.output = presenter

			return interactor
		}

		container.register(SettingsRouter.self) { (_, viewController: SettingsViewController) in
			let router = SettingsRouter()
			router.transitionHandler = viewController

			return router
		}

		container.register(SettingsPresenter.self) { (r, viewController: SettingsViewController) in
			let presenter = SettingsPresenter()
			presenter.view = viewController
			presenter.interactor = r.resolve(SettingsInteractor.self, argument: presenter)
			presenter.router = r.resolve(SettingsRouter.self, argument: viewController)

			return presenter
		}
        
        container.storyboardInitCompleted(SettingsViewController.self) { r, viewController in
            viewController.output = r.resolve(SettingsPresenter.self, argument: viewController)
        }

	}

}
