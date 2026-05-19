import 'package:flutter/material.dart';

class Pertemuan9Page extends StatelessWidget {
  const Pertemuan9Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date & Time Picker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const DateTimePickerForm(),
    );
  }
}

class DateTimePickerForm extends StatefulWidget {
  const DateTimePickerForm({super.key});

  @override
  State<DateTimePickerForm> createState() => _DateTimePickerFormState();
}

class _DateTimePickerFormState extends State<DateTimePickerForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  DateTime? _selectedDateTime;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  // Month names (Indonesian)
  static const List<String> _namaBulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} ${_namaBulan[d.month - 1]} ${d.year}';

  String _fmtDateShort(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}'
      '${_namaBulan[d.month - 1].substring(0, 3)}'
      '${d.year}';

  String _fmtTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:'
      '${t.minute.toString().padLeft(2, '0')}';

  // Pickers
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: _pickerTheme,
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _fmtDate(picked);
      });
    }
  }


  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: _pickerTheme,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _fmtTime(picked);
      });
    }
  }


  Future<void> _pickDateRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange:
        (_selectedStartDate != null && _selectedEndDate != null)
          ? DateTimeRange(start: _selectedStartDate!, end: _selectedEndDate!)
          : null,
      builder: _pickerTheme,
    );
    if (range != null) {
      setState(() {
        _selectedStartDate = range.start;
        _selectedEndDate = range.end;
        _startDateController.text = _fmtDateShort(range.start);
        _endDateController.text = _fmtDateShort(range.end);
      });
    }
  }


  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: _pickerTheme,
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: _selectedDateTime != null
          ? TimeOfDay.fromDateTime(_selectedDateTime!)
          : TimeOfDay.now(),
      builder: _pickerTheme,
    );
    if (time == null) return;

    final combined =
      DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      _selectedDateTime = combined;
      _dateTimeController.text = '${_fmtDate(combined)}, ${_fmtTime(time)}';
    });
  }

  // Picker theme helper
  Widget _pickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF6C63FF),
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: const Color(0xFF1A1A2E),
        ),
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child: child !,
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text('Form berhasil disimpan!')),
          ],),
          backgroundColor: const Color(0xFF6C63FF),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  void _reset() {
    _formKey.currentState?.reset();
    setState(() {
      _selectedDate = null;
      _selectedTime = null;
      _selectedStartDate = null;
      _selectedEndDate = null;
      _selectedDateTime = null;
      for (final c in [
        _titleController, _dateController, _timeController,
        _startDateController, _endDateController, _dateTimeController,
      ]) {
        c.clear();
      }
    });
  }

  bool get _hasAnyValue =>
    _titleController.text.isNotEmpty ||
    _dateController.text.isNotEmpty ||
    _timeController.text.isNotEmpty ||
    _startDateController.text.isNotEmpty ||
    _dateTimeController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        title: const Text('Date & Time Picker',
            style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionCard(
                icon: Icons.event_note_rounded,
                title: 'Informasi Acara',
                child: _buildTextField(
                  controller: _titleController,
                  label: 'Judul Acara',
                  hint: 'Contoh: Meeting Tim',
                  icon: Icons.title_rounded,
                  validator: (v) =>
                    v!.isEmpty ? 'Judul tidak boleh kosong' : null,
                ),
              ),
              const SizedBox(height: 16),
              SectionCard(
                icon: Icons.calendar_today_rounded,
                title: 'Pilih Tanggal',
                child: _buildPickerField(
                  controller: _dateController,
                  label: 'Tanggal',
                  hint: 'Ketuk untuk memilih tanggal',
                  icon: Icons.calendar_today_rounded,
                  onTap: _pickDate,
                  validator: (v) =>
                    v!.isEmpty ? 'Tanggal wajib dipilih' : null,
                ),
              ),
              const SizedBox(height: 16),
              SectionCard(
                icon: Icons.access_time_rounded,
                title: 'Pilih Waktu',
                child: _buildPickerField(
                  controller: _timeController,
                  label: 'Waktu',
                  hint: 'Ketuk untuk memilih waktu',
                  icon: Icons.access_time_rounded,
                  onTap: _pickTime,
                  validator: (v) =>
                    v!.isEmpty ? 'Waktu wajib dipilih' : null,
                ),
              ),
              const SizedBox(height: 16),
              SectionCard(
                icon: Icons.date_range_rounded,
                title: 'Rentang Tanggal',
                child: Column(
                  children: [
                    _buildPickerField(
                      controller: _startDateController,
                      label: 'Tanggal Mulai',
                      hint: 'Ketuk untuk memilih rentang',
                      icon: Icons.play_circle_outline_rounded,
                      onTap: _pickDateRange,
                    ),
                    const SizedBox(height: 12),
                    _buildPickerField(
                      controller: _endDateController,
                      label: 'Tanggal Selesai',
                      hint: 'Otomatis terisi saat pilih rentang',
                      icon: Icons.stop_circle_outlined,
                      onTap: _pickDateRange,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SectionCard(
                icon: Icons.schedule_rounded,
                title: 'Tanggal & Waktu Sekaligus',
                child: _buildPickerField(
                  controller: _dateTimeController,
                  label: 'Tanggal & Waktu',
                  hint: 'Ketuk untuk memilih tanggal & waktu',
                  icon: Icons.calendar_month_rounded,
                  onTap: _pickDateTime,
                ),
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: _submit,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                icon: const Icon(Icons.save_rounded),
                label: const Text('Simpan'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF6C63FF),
                  side: const BorderSide(color : Color(0xFF6C63FF) ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Reset Form'),
              ),
              const SizedBox(height: 24),
              if (_hasAnyValue) _buildPreviewCard(),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: _deco(label: label, hint: hint, icon: icon),
    );
  }

  Widget _buildPickerField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required VoidCallback onTap,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      validator: validator,
      decoration: _deco(
        label: label,
        hint: hint,
        icon: icon,
        suffix: const Icon(Icons.chevron_right_rounded,
            color: Color(0xFF6C63FF), size: 20),
      ),
    );
  }

  InputDecoration _deco({
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF6C63FF)),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFFF5F4FF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 1.5),),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
      labelStyle: const TextStyle(color: Color(0xFF6B7280)),
      hintStyle: const TextStyle(color: Color(0xFFB0B7C3), fontSize: 14),
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF).withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color : Color(0xFF6C63FF).withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [
            Icon(Icons.preview_rounded, color: Color(0xFF6C63FF)),
            SizedBox(width: 6),
            Text('Preview Data',
                style: TextStyle(
                    color: Color(0xFF6C63FF),
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
          ]),
          const Divider(height: 16),
          if (_titleController.text.isNotEmpty)
            _previewRow(Icons.title_rounded, 'Judul', _titleController.text),
          if (_dateController.text.isNotEmpty)
            _previewRow(Icons.calendar_today_rounded, 'Tanggal', _dateController.text),
          if (_timeController.text.isNotEmpty)
            _previewRow(Icons.access_time_rounded, 'Waktu', _timeController.text),
          if (_startDateController.text.isNotEmpty)
            _previewRow(Icons.date_range_rounded, 'Rentang',
                '${_startDateController.text} - ${_endDateController.text}'),
          if (_dateTimeController.text.isNotEmpty)
            _previewRow(Icons.schedule_rounded, 'Tgl & Waktu', _dateTimeController.text),
        ],
      ),
    );
  }

  Widget _previewRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
          Icon(icon, size: 15, color: const Color(0xFF6C63FF)),
          const SizedBox(width: 6),
          Text('$label: ',
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0xFF4B5563))),
          Expanded(
              child: Text(value,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF1A1A2E)),
                  overflow: TextOverflow.ellipsis)),
      ]),
    );
  }
}


class SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const SectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF6C63FF)),
            ),
            const SizedBox(width: 10),
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF1A1A2E))),
          ]),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}