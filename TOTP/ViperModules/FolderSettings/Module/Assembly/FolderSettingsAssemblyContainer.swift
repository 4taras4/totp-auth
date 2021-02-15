//
//  FolderSettingsFolderSettingsAssemblyContainer.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import Swinject

final class FolderSettingsAssemblyContainer: Assembly {

	func assemble(container: Container) {
		container.register(FolderSettingsInteractor.self) { (_, presenter: FolderSettingsPresenter) in
			let interactor = FolderSettingsInteractor()
			interactor.output = presenter

			return interactor
		}

		container.register(FolderSettingsRouter.self) { (_, viewController: FolderSettingsViewController) in
			let router = FolderSettingsRouter()
			router.transitionHandler = viewController

			return router
		}

		container.register(FolderSettingsPresenter.self) { (r, viewController: FolderSettingsViewController) in
			let presenter = FolderSettingsPresenter()
			presenter.view = viewController
			presenter.interactor = r.resolve(FolderSettingsInteractor.self, argument: presenter)
			presenter.router = r.resolve(FolderSettingsRouter.self, argument: viewController)

			return presenter
		}

        container.storyboardInitCompleted(FolderSettingsViewController.self) { r, viewController in
            viewController.output = r.resolve(FolderSettingsPresenter.self, argument: viewController)
        }
	}

}
