import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_counter/view/events_list/add_code_dialog.dart';
import '../../repositories/saved_codes/saved_codes_repository.dart';
import '../../blocs/code_list/code_list_bloc.dart';
import '../../blocs/code_list/code_list_event.dart';
import '../../blocs/code_list/code_list_state.dart';
import '../shared/error_page.dart';

import '../../errors/bloc_fall_through_error.dart';
import '../shared/loading_page.dart';
import 'events_list_item.dart';

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const EventsListScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CodeListBloc(
        savedCodesRepository: context.read<SavedCodesRepository>(),
      )..add(const LoadSavedCodesEvent()),
      child: const EventsListView(),
    );
  }
}

class EventsListView extends StatelessWidget {
  const EventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeListBloc, CodeListState>(builder: (context, state) {
      if (state is CodeListLoaded) {
        return EventsListLoadedView(codes: state.codes);
      }
      if (state is CodeListLoading) {
        return const Scaffold(
          body: LoadingPage(message: 'Loading saved codes...'),
        );
      }
      if (state is CodeListUnloaded) {
        return const Scaffold(
          body: LoadingPage(message: 'Events list loading not started.'),
        );
      }
      if (state is CodeListError) {
        return Scaffold(
          body: ErrorPage(message: state.message),
        );
      }
      throw BlocFallThroughError('Code list bloc state not supported.');
    });
  }
}

class EventsListLoadedView extends StatelessWidget {
  final List<String> codes;

  const EventsListLoadedView({super.key, required this.codes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addCodeDialog(context),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: codes.length,
        separatorBuilder: (context, _) => const Divider(),
        itemBuilder: (context, index) => EventsListItem(code: codes[index]),
      ),
    );
  }

  void _addCodeDialog(BuildContext context) {
    showDialog<String?>(
      context: context,
      builder: (context) => const AddCodeDialog(),
    ).then((value) {
      if (value == null) {
        return;
      }
      context.read<CodeListBloc>().add(AddCodeEvent(value));
    });
  }
}
