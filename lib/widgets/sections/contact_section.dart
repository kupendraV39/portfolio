import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../constants/app_colors.dart';
import '../../constants/app_config.dart';
import '../../utils/responsive.dart';
import '../atoms/section_header.dart';
import '../canvas/earth_3d.dart';

/// Mirrors sections/Contact.tsx — form + Earth 3D model.
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': dotenv.env['EMAILJS_SERVICE_ID'] ?? '',
          'template_id': dotenv.env['EMAILJS_TEMPLATE_ID'] ?? '',
          'user_id': dotenv.env['EMAILJS_PUBLIC_KEY'] ?? '',
          'template_params': {
            'form_name': _nameCtrl.text,
            'to_name': AppConfig.fullName,
            'from_email': _emailCtrl.text,
            'to_email': AppConfig.email,
            'message': _messageCtrl.text,
          },
        }),
      );

      if (response.statusCode == 200) {
        _nameCtrl.clear();
        _emailCtrl.clear();
        _messageCtrl.clear();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Thank you! I will get back to you as soon as possible.'),
              backgroundColor: AppColors.accent,
            ),
          );
        }
      } else {
        throw Exception('Failed: ${response.statusCode}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Please try again.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final form = _ContactForm(
      formKey: _formKey,
      nameCtrl: _nameCtrl,
      emailCtrl: _emailCtrl,
      messageCtrl: _messageCtrl,
      loading: _loading,
      onSubmit: _submit,
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 800.ms)
        .slideX(begin: -0.3, delay: 200.ms, duration: 800.ms);

    final earth = const SizedBox(
      height: 400,
      child: Earth3D(),
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 800.ms)
        .slideX(begin: 0.3, delay: 200.ms, duration: 800.ms);

    return isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: form),
              const SizedBox(width: 40),
              Expanded(flex: 2, child: earth),
            ],
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  form,
                  const SizedBox(height: 40),
                  earth,
                ],
              ),
            ),
          );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm({
    required this.formKey,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.messageCtrl,
    required this.loading,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController messageCtrl;
  final bool loading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.black100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                subtitle: AppConfig.contactSub,
                title: AppConfig.contactHead,
                animate: false,
              ),
              const SizedBox(height: 40),

              _FormField(
                label: AppConfig.contactNameLabel,
                placeholder: AppConfig.contactNamePlaceholder,
                controller: nameCtrl,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 24),

              _FormField(
                label: AppConfig.contactEmailLabel,
                placeholder: AppConfig.contactEmailPlaceholder,
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter your email';
                  if (!v.contains('@')) return 'Please enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 24),

              _FormField(
                label: AppConfig.contactMsgLabel,
                placeholder: AppConfig.contactMsgPlaceholder,
                controller: messageCtrl,
                maxLines: 7,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Please enter a message' : null,
              ),
              const SizedBox(height: 32),

              SizedBox(
                child: ElevatedButton(
                  onPressed: loading ? null : onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tertiary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    loading ? 'Sending...' : 'Send',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20), // 👈 prevents bottom cut
            ],
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    required this.placeholder,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  final String label;
  final String placeholder;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.poppins(color: AppColors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.poppins(
              color: AppColors.secondary,
              fontSize: 14,
            ),
            filled: true,
            fillColor: AppColors.tertiary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
