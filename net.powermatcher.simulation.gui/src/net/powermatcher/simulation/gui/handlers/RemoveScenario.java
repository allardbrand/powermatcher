package net.powermatcher.simulation.gui.handlers;

import net.powermatcher.simulation.configuration.ScenarioDescriptor;
import net.powermatcher.simulation.gui.operations.RemoveScenarioOperation;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.commands.operations.IUndoableOperation;
import org.eclipse.jface.viewers.StructuredSelection;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.handlers.HandlerUtil;

public class RemoveScenario extends AbstractHandler {

	@Override
	public Object execute(ExecutionEvent event) throws ExecutionException {
		StructuredSelection selection = (StructuredSelection) HandlerUtil.getActiveMenuSelection(event);
		if (selection == null || selection.isEmpty()) {
			return null;
		}

		Object firstElement = selection.getFirstElement();
		if (firstElement instanceof ScenarioDescriptor) {
			ScenarioDescriptor scenarioDescriptor = (ScenarioDescriptor) selection.getFirstElement();
			IUndoableOperation operation = new RemoveScenarioOperation(scenarioDescriptor);

			IWorkbench workbench = PlatformUI.getWorkbench();
			operation.addContext(workbench.getOperationSupport().getUndoContext());
			workbench.getOperationSupport().getOperationHistory().execute(operation, null, null);
		}

		return null;
	}

}
