import 'package:flutter/material.dart';

import '../profile.dart';
import '../widgets/sidebar.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _dark = Color(0xFF1C1C1E);
const Color _placeholderGrey = Color(0xFF8E8E93);
const Color _dividerBg = Color(0xFFEFEFF4);
const Color _linkBlue = Color(0xFF3B82F6);

class CitationScreen extends StatefulWidget {
  const CitationScreen({super.key});

  @override
  State<CitationScreen> createState() => _CitationScreenState();
}

class _CitationScreenState extends State<CitationScreen> {
  bool _isFileUploaded = false;
  bool _isCited = false;

  final TextEditingController _journalProfileController =
      TextEditingController();
  String _selectedStyle = 'APA';

  final List<String> _citationStyles = [
    'APA',
    'MLA',
    'Chicago',
    'IEEE',
    'Harvard',
  ];

  void _handleUploadFile() {
    setState(() {
      _isFileUploaded = true;
    });
  }

  void _handleCite() {
    setState(() {
      _isCited = true;
    });
  }

  void _handleTryAgain() {
    setState(() {
      _isCited = false;
      _isFileUploaded = false;
      _journalProfileController.clear();
      _selectedStyle = 'APA';
    });
  }

  @override
  void dispose() {
    _journalProfileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _panel,
      drawer: const SidebarDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            const Divider(height: 1, thickness: 1, color: _border),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    _CiteDefaultView(
                      profileController: _journalProfileController,
                      selectedStyle: _selectedStyle,
                      citationStyles: _citationStyles,
                      isFileUploaded: _isFileUploaded,
                      onUploadTap: _handleUploadFile,
                      onStyleChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedStyle = val);
                        }
                      },
                      onCite: _handleCite,
                    ),

                    _isCited
                        ? _CiteResultView(onTryAgain: _handleTryAgain)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== HEADER ====================
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _Hamburger(),
          const Text(
            'Citation AI',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF666666),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.account_circle, size: 28, color: _dark),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Hamburger extends StatelessWidget {
  const _Hamburger();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: const SizedBox(
        width: 40,
        height: 40,
        child: Icon(Icons.menu, size: 32, color: _dark),
      ),
    );
  }
}

// ==================== DEFAULT VIEW (Cite-default) ====================
class _CiteDefaultView extends StatelessWidget {
  const _CiteDefaultView({
    required this.profileController,
    required this.selectedStyle,
    required this.citationStyles,
    required this.isFileUploaded,
    required this.onUploadTap,
    required this.onStyleChanged,
    required this.onCite,
  });

  final TextEditingController profileController;
  final String selectedStyle;
  final List<String> citationStyles;
  final bool isFileUploaded;
  final VoidCallback onUploadTap;
  final ValueChanged<String?> onStyleChanged;
  final VoidCallback onCite;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title & Logo Section
        const Icon(Icons.widgets_outlined, size: 52, color: _dark),
        const SizedBox(height: 12),
        const Text(
          'Citation \nAssistant',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _dark,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'AI Student Assistant',
          style: TextStyle(fontSize: 12.5, color: _placeholderGrey),
        ),
        const SizedBox(height: 32),

        // Unified Card (Sesuai Desain Referensi Gambar)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Action Row (Book Dropdown & Cite Manually)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Book',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: _dark,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down, size: 18, color: _dark),
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        'APA 7th Edition',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: _dark,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down, size: 18, color: _dark),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Search Input Bar dengan Tombol Cite di dalam Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFDCDCE0)),
                ),
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 6,
                  top: 4,
                  bottom: 4,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 20, color: _placeholderGrey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: profileController,
                        style: const TextStyle(fontSize: 13.5, color: _dark),
                        decoration: const InputDecoration(
                          hintText: 'Search by ISBN or book title...',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFA0A0A5),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: onCite,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _dark,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Cite',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Bottom Action Row (Upload PDF Button / Status)
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: onUploadTap,
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isFileUploaded
                              ? Icons.check_circle_outline
                              : Icons.upload_file_rounded,
                          size: 16,
                          color: isFileUploaded
                              ? Colors.green
                              : const Color(0xFF555555),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isFileUploaded ? 'file_document.pdf' : 'Upload PDF',
                          style: TextStyle(
                            fontSize: 13,
                            color: isFileUploaded
                                ? Colors.green
                                : const Color(0xFF555555),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CrossSectionInput extends StatelessWidget {
  const CrossSectionInput({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: _dark,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5E5EA)),
          ),
          child: child,
        ),
      ],
    );
  }
}

// ==================== RESULT VIEW (Cite-Result) ====================
class _CiteResultView extends StatelessWidget {
  const _CiteResultView({required this.onTryAgain});

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5EA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title: Cite
          const Text(
            'Cite',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _dark,
            ),
          ),
          const SizedBox(height: 4),
          const Divider(color: _border, thickness: 1),
          const SizedBox(height: 12),

          // Citation Text Content
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 13, color: _dark, height: 1.45),
              children: [
                TextSpan(
                  text:
                      'Juliana, S. A., Astuti, I. W., Pramesti, R. D., & Junaedi, F. (2024). Tinjauan Etika dalam Promosi Galon Cleo di Akun Instagram @stefanigabriela. ',
                ),
                TextSpan(
                  text: 'Borobudur Communication Review',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                TextSpan(text: ', 4(1), 1–17. '),
                TextSpan(
                  text: 'https://doi.org/10.31603/bcrev.10585',
                  style: TextStyle(
                    color: _linkBlue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Button Copy Citation
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _dark,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
            ),
            icon: const Icon(Icons.copy_outlined, size: 16),
            label: const Text(
              'Copy',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 16),
          const Divider(color: _border, thickness: 1),
          const SizedBox(height: 16),

          // Parenthetical Section
          Row(
            children: const [
              Text(
                'Parenthetical',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: _dark,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.info_outline, size: 15, color: _placeholderGrey),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '(Juliana et al., 2024)',
                style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.copy_outlined, size: 18, color: _dark),
                onPressed: () {},
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Narrative Section
          Row(
            children: const [
              Text(
                'Narrative',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: _dark,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.info_outline, size: 15, color: _placeholderGrey),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Juliana et al. (2024)',
                style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.copy_outlined, size: 18, color: _dark),
                onPressed: () {},
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Try Again Button
          OutlinedButton(
            onPressed: onTryAgain,
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFEFEFF4),
              foregroundColor: _dark,
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Try Again',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
